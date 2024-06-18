# https://wiki.archlinux.org/title/NVIDIA/Troubleshooting#Visual_issues
# ForceFullCompositionPipeline can break some games: https://github.com/ValveSoftware/Proton/issues/6869
if command -v nvidia-settings &> /dev/null
then
    nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
fi
