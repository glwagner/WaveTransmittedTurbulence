module WaveTransmittedTurbulence

export
    # top level
    select_device!,

    # output.jl
    horizontal_averages,
    FieldSlice,
    FieldSlices,
    XYSlice,
    XYSlices,
    YZSlice,
    YZSlices,
    XZSlice,
    XZSlices,

    # forcing.jl
    μ,
    Ψᵢ,
    Fu,
    Fv,
    Fw,
    Fθ,
    Fs,
    Fb,

    # setup.jl
    save_global!,
    print_banner,
    prefix_tuple_names,

    # files.jl
    get_iters,
    get_time,
    get_final_time,
    get_grid,
    get_fields,
    get_statistics,
    get_wind_stress,
    get_surface_wave_parameters,
    get_parameter,
    get_multiple_parameters,
    set_from_file!,
    calculate_horizontal_average_timeseries,
    collect_horizontal_averages,

    # les.jl
    SurfaceEnhancedModelConstant,
    SurfaceFluxDiffusivityBoundaryConditions,
    save_closure_parameters!,

    # progress_messenger.jl
    SimulationProgressMessenger,

    # stokes_drift.jl
    uˢ,
    GrowingStokesDrift,
    SteadyStokesDrift,
    EffectiveStressGrowingStokesDrift,

    # visualization.jl
    stretch_x!,
    stretch_y!,
    shift_up!,
    shift_down!,
    shift_left!,
    shift_right!,
    sequential_limit_levels,
    divergent_limit_levels,
    make_plot,
    bottom_left_text!,
    usecmbright,
    defaultcolors,
    removespines,
    axes_grid1,
    meshgrid,
    get_position,
    plot_profiles!,
    
    # reexport from Oceananigans / CUDAapi
    @hascuda,
    has_cuda

using OffsetArrays, JLD2, Printf, Glob, Statistics, PyPlot, PyCall

using Oceananigans,
      Oceananigans.AbstractOperations,
      Oceananigans.BoundaryConditions,
      Oceananigans.TurbulenceClosures,
      Oceananigans.Diagnostics,
      Oceananigans.Fields,
      Oceananigans.Operators,
      Oceananigans.Grids,
      Oceananigans.Utils

using Oceananigans.Architectures: device

using Oceananigans.SurfaceWaves: UniformStokesDrift

using Oceananigans.Buoyancy: g_Earth

using Oceananigans: @hascuda, Face, Cell

using Oceananigans.Fields: xnodes, ynodes, znodes

using GPUifyLoops: @loop, @launch

using CUDAapi: has_cuda

@hascuda begin
    using CUDAnative, CUDAdrv

    function select_device!(ndev)
        @show dev = CuDevice(ndev)
        CUDAnative.device!(dev)
        return nothing
    end
end

include("utils.jl")
include("analysis.jl")
include("output.jl")
include("forcing.jl")
include("files.jl")
include("les.jl")
include("progress_messenger.jl")
include("visualization.jl")
include("stokes_drift.jl")

end # module
