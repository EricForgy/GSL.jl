#!/usr/bin/env julia
#GSL Julia wrapper
#(c) 2013 Jiahao Chen <jiahao@mit.edu>
##############################################
# 7.5.1 Regular Cylindrical Bessel Functions #
##############################################
export sf_bessel_J0, sf_bessel_J0_e, sf_bessel_J1, sf_bessel_J1_e,
       sf_bessel_Jn, sf_bessel_Jn_e, sf_bessel_Jn_array


# These routines compute the regular cylindrical Bessel function of zeroth
# order, J_0(x).
# 
#   Returns: Cdouble
function sf_bessel_J0(x::Real)
    ccall( (:gsl_sf_bessel_J0, :libgsl), Cdouble, (Cdouble, ), x )
end
@vectorize_1arg Number sf_bessel_J0


# These routines compute the regular cylindrical Bessel function of zeroth
# order, J_0(x).
# 
#   Returns: Cint
function sf_bessel_J0_e(x::Real)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    errno = ccall( (:gsl_sf_bessel_J0_e, :libgsl), Cint, (Cdouble,
        Ptr{gsl_sf_result}), x, result )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_ref(result)[1]
end
@vectorize_1arg Number sf_bessel_J0_e


# These routines compute the regular cylindrical Bessel function of first
# order, J_1(x).
# 
#   Returns: Cdouble
function sf_bessel_J1(x::Real)
    ccall( (:gsl_sf_bessel_J1, :libgsl), Cdouble, (Cdouble, ), x )
end
@vectorize_1arg Number sf_bessel_J1


# These routines compute the regular cylindrical Bessel function of first
# order, J_1(x).
# 
#   Returns: Cint
function sf_bessel_J1_e(x::Real)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    errno = ccall( (:gsl_sf_bessel_J1_e, :libgsl), Cint, (Cdouble,
        Ptr{gsl_sf_result}), x, result )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_ref(result)[1]
end
@vectorize_1arg Number sf_bessel_J1_e


# These routines compute the regular cylindrical Bessel function of order n,
# J_n(x).
# 
#   Returns: Cdouble
function sf_bessel_Jn(n::Integer, x::Real)
    ccall( (:gsl_sf_bessel_Jn, :libgsl), Cdouble, (Cint, Cdouble), n, x )
end
@vectorize_2arg Number sf_bessel_Jn


# These routines compute the regular cylindrical Bessel function of order n,
# J_n(x).
# 
#   Returns: Cint
function sf_bessel_Jn_e(n::Integer, x::Real)
    result = convert(Ptr{gsl_sf_result}, Array(gsl_sf_result, 1))
    errno = ccall( (:gsl_sf_bessel_Jn_e, :libgsl), Cint, (Cint, Cdouble,
        Ptr{gsl_sf_result}), n, x, result )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_ref(result)[1]
end
@vectorize_2arg Number sf_bessel_Jn_e


# This routine computes the values of the regular cylindrical Bessel functions
# J_n(x) for n from nmin to nmax inclusive, storing the results in the array
# result_array.  The values are computed using recurrence relations for
# efficiency, and therefore may differ slightly from the exact values.
# 
#   Returns: Cint
function sf_bessel_Jn_array(nmin::Integer, nmax::Integer, x::Real)
    result_array = convert(Cdouble, Array(Cdouble, 1))
    errno = ccall( (:gsl_sf_bessel_Jn_array, :libgsl), Cint, (Cint, Cint,
        Cdouble, Cdouble), nmin, nmax, x, result_array )
    if errno!= 0 throw(GSL_ERROR(errno)) end
    return unsafe_ref(result_array)[1]
end
#TODO This vectorization macro is not implemented
#@vectorize_3arg Number sf_bessel_Jn_array