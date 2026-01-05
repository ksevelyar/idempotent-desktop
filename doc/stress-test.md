# Stress test

## Stress
```fish
nix-shell -p stress-ng --run \
'sudo stress-ng \
  --cpu 0 \
  --vm 8 \
  --vm-bytes 80% \
  --vm-method all \
  --matrix 0 \
  --timeout 15m \
  --metrics-brief'
```

```
stress-ng: info:  [1923475] setting to a 15 mins run per stressor
stress-ng: info:  [1923475] dispatching hogs: 16 cpu, 8 vm, 16 matrix
stress-ng: info:  [1923475] note: 16 cpus have scaling governors set to powersave and this may impact performance; setting /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor to 'performance' may improve performance
stress-ng: info:  [1923492] vm: using 588.08M per stressor instance (total 4.59G of 5.71G available memory)
stress-ng: metrc: [1923475] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s
stress-ng: metrc: [1923475]                           (secs)    (secs)    (secs)   (real time) (usr+sys time)
stress-ng: metrc: [1923475] cpu            10256688    900.00   5599.75      1.93     11396.30        1831.00
stress-ng: metrc: [1923475] vm             27263134    900.02   2750.18     63.00     30291.53        9691.21
stress-ng: metrc: [1923475] matrix         28279938    899.99   5646.34      1.89     31422.42        5006.86
stress-ng: info:  [1923475] skipped: 0
stress-ng: info:  [1923475] passed: 40: cpu (16) vm (8) matrix (16)
stress-ng: info:  [1923475] failed: 0
stress-ng: info:  [1923475] metrics untrustworthy: 0
stress-ng: info:  [1923475] successful run completed in 15 mins
```

## Sensors
```fish
watch -n 1 '
sensors 2>/dev/null | awk "
/spd5118/        {dimm=1}
/temp1:/ && dimm {printf \"DIMM      : %s / <= +70°C (review), >= +85°C (stop)\\n\", \$2; dimm=0}

/^Composite:/    {printf \"NVMe      : %s / <= +70°C (ok),  >= +80°C (stop)\\n\", \$2}

/^Tctl:/         {printf \"CPU Tctl  : %s / <= +95°C (ok),  >= +95°C sustained (stop)\\n\", \$2}

/amdgpu-pci-0300/ {gpu=1}
/^edge:/ && gpu    {printf \"GPU edge  : %s / <= +85°C (ok)\\n\", \$2}
/^junction:/ && gpu {printf \"GPU junc  : %s / <= +95°C (ok),  >= +105°C (stop)\\n\", \$2}
/^mem:/ && gpu     {printf \"GPU mem   : %s / <= +90°C (ok),  >= +100°C (stop)\\n\", \$2; gpu=0}
"
'
```

```
Every 1.0s:

DIMM      : +39.5°C / <= +70°C (review), >= +85°C (stop)
NVMe      : +40.9°C / <= +70°C (ok),  >= +80°C (stop)
GPU edge  : +36.0°C / <= +85°C (ok)
GPU junc  : +37.0°C / <= +95°C (ok),  >= +105°C (stop)
GPU mem   : +60.0°C / <= +90°C (ok),  >= +100°C (stop)
CPU Tctl  : +83.6°C / <= +95°C (ok),  >= +95°C sustained (stop)
```
