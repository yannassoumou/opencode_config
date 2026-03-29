# Record 3 seconds using Poly headset mic

arecord -D sysdefault:CARD=Series -f cd -r 16000 -c 1 test_mic.wav

# (speak now! 👇)

# Press Ctrl+C after ~3 sec

# Play back your voice (through Poly headphones)

aplay -D sysdefault:CARD=Series test_mic.wav

export ALSA_PCM_CARD=Series
export TTS_IN_DEVICE="sysdefault:CARD=Series"
export TTS_OUT_DEVICE="sysdefault:CARD=Series"

# Kill and restart PipeWire (resets everything)

systemctl --user restart pipewire pipewire-pulse

# Wait for it to fully start

sleep 3

# Now check sinks

pactl list sinks short
