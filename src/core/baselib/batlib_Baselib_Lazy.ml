(*
 * Batlib_Baselib_Lazy - Importing Base module Lazy
 * Copyright (C) 2008 David Teller
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version,
 * with the special exception on linking described in file LICENSE.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *)

include Lazy

TYPE_CONV_PATH "Batteries.Data.Persistent.Lazy" (*For Sexplib, Bin-prot...*)

let t_of_sexp = Sexplib.Conv.lazy_of_sexp
let sexp_of_t = Sexplib.Conv.sexp_of_lazy