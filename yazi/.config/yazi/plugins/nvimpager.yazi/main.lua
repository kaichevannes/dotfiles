local M = {}

function M:peek(job)
	local child = Command("nvimpager"):arg({ "-c", tostring(job.file.url) })
		:env("NVIM_APPNAME", "nvimpager")
		:stdout(Command.PIPED):stderr(Command.PIPED):spawn()

	local limit = job.area.h
	local i, lines = 0, ""
	repeat
		local line, event = child:read_line()
		if event == 1 then ya.err(tostring(line)) break
		elseif event ~= 0 then break end
		i = i + 1
		if i > job.skip then lines = lines .. line end
	until i >= job.skip + limit

	child:start_kill()
  ya.preview_widget(job, {
		ui.Text.parse(lines):area(job.area):wrap(ui.Wrap.NO),
	})
end

function M:seek(job)
	local h = cx.active.current.hovered
	if h and h.url == job.file.url then
		local step = math.floor(job.units * job.area.h / 10)
		ya.mgr_emit("peek", {
			math.max(0, cx.active.preview.skip + step),
			only_if = job.file.url,
		})
	end
end

return M
