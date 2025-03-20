local lastnotify = 0

concommand.Add("warnnotify", function()

end

net.Receive("YAS_Warning", function()
	local type = net.ReadInt(5)
	local admin = net.ReadString()
	local text = net.ReadString()
	local priority = net.ReadString()


end)

hook.Add("RenderScreenspaceEffects", "MotionBlurEffectWarn", function()
	DrawMotionBlur( 0.4, 0.8, 0.01 )
end)