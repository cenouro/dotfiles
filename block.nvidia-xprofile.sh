# https://wiki.archlinux.org/title/NVIDIA/Troubleshooting#Visual_issues
# ForceFullCompositionPipeline can break some games: https://github.com/ValveSoftware/Proton/issues/6869
if command -v nvidia-settings &> /dev/null
then
    # When 'using' prime-select, nvidia-settings can't manage the GPU
    # and will issue an error. The following 'if' is only executed
    # when NOT using prime-select. Note that prime-select is installed
    # and available even when not being used, thus the check uses
    # gpu-manager instead.
    if ( command -v gpu-manager &> /dev/null ) && ( gpu-manager | grep -Fiq "last cards number = 1" )
    then
        nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
        nvidia-settings --assign GPULogoBrightness=0
    fi
fi
