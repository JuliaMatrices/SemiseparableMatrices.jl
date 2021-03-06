module SemiseparableMatrices
using ArrayLayouts, BandedMatrices, LazyArrays, LinearAlgebra, MatrixFactorizations, LazyBandedMatrices, Base

import Base: size, getindex, setindex!, convert, copyto!
import MatrixFactorizations: QR, QRPackedQ, getQ, getR, QRPackedQLayout, AdjQRPackedQLayout
import LinearAlgebra: qr, qr!, lmul!, ldiv!, rmul!, triu!, factorize, rank
import BandedMatrices: _banded_qr!, bandeddata
import LazyArrays: arguments, applylayout, _cache, CachedArray, CachedMatrix, ApplyLayout, resizedata!
import ArrayLayouts: MemoryLayout, sublayout, sub_materialize, MatLdivVec, materialize!, triangularlayout, 
                        triangulardata, zero!, _copyto!, colsupport, rowsupport,
                        _qr, _qr!, _factorize
import LazyBandedMatrices: resize

export SemiseparableMatrix, AlmostBandedMatrix, LowRankMatrix, ApplyMatrix, ApplyArray, almostbandwidths, almostbandedrank

const LowRankMatrix{T,A,B} = MulMatrix{T,Tuple{A,B}}
LowRankMatrix(A::AbstractArray, B::AbstractArray) = ApplyMatrix(*, A, B)
LowRankMatrix(S::SubArray) = LowRankMatrix(map(Array,arguments(S))...)
LowRankMatrix{T}(::UndefInitializer, (m,n)::NTuple{2,Integer}, r::Integer) where T = 
    ApplyMatrix(*, Array{T}(undef, m, r), Array{T}(undef, r, n))

separablerank(A) = size(arguments(ApplyLayout{typeof(*)}(),A)[1],2)    

include("SemiseparableMatrix.jl")
include("AlmostBandedMatrix.jl")
include("invbanded.jl")

end # module
