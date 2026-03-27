swayimg.viewer.on_key("Left", function()
  swayimg.viewer.switch_image("prev")
end)

swayimg.viewer.on_key("Right", function()
  swayimg.viewer.switch_image("next")
end)

swayimg.text.set_timeout(0)
