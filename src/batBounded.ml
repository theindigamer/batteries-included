module O = BatOrd

type 'a bounding_f = min:'a -> max:'a -> 'a -> 'a option

let bounding_of_ord ?default_low ?default_high ord = 
  fun ~min ~max -> assert (ord min max != O.Gt); 
  fun x ->
    match ord x min, ord x max with
    | O.Lt, _ -> default_low
    | _, O.Gt -> default_high
    | O.Eq, _
    | _, O.Eq
    | O.Gt, _ -> Some x

module type BoundedOrdType = sig
  type t
  val min : t
  val max : t
  val ord : t -> t -> BatOrd.order
  val default_high : t option
  val default_low : t option
end

module type BoundedType = sig
  type t
  val min : t
  val max : t
  val bounded : t bounding_f
  val default_high : t option
  val default_low : t option
end

module type S = sig
  type u
  type t = private u
  exception Out_of_range
  val min : t
  val max : t
  val default_high : t option
  val default_low : t option
  val make : u -> t option
  val make_exn : u -> t
end

module Make(M : BoundedType) : (S with type u = M.t) = struct
  include M
  type u = t
  exception Out_of_range
  let make x = bounded ~min ~max x
  let make_exn x =
    match make x with
    | Some n -> n
    | None -> raise Out_of_range
end

module MakeOrd(M : BoundedOrdType) : (S with type u = M.t) = struct
  include M
  type u = t
  exception Out_of_range
  let make x = bounding_of_ord ?default_low ?default_high ord ~min ~max x
  let make_exn x = BatOption.get_exn (make x) Out_of_range
end

module Int10_base = struct
  type t = int
  let min = 1
  let max = 10
  let default_low = Some 1
  let default_high = Some 10
  let bounded = bounding_of_ord ?default_low ?default_high BatInt.ord
end

(** Only accept integers between 1 and 10 *)
module Int10 = Make(Int10_base)

module Int10_base_ord = struct
  type t = int
  let min = 1
  let max = 10
  let default_low = Some 1
  let default_high = Some 10
  let ord = BatInt.ord
end

(** Only accept integers between 1 and 10 *)
module Int10_ord = MakeOrd(Int10_base_ord)

