local switcher = {}

-- * para este metodo, a sheet precisa estar toda na horizontal *
-- shet: string do caminho da imagem com todos 'botoes' mais focus
-- quadcoords: tabela com as coordenas de cada 'botao' NA sheet
--             { {10, 10}, {50, 99}, ... }
-- qw: quad width
-- qh: quad height
-- total: quantidade de imagens NA sheet
function createsheetandquads(sheet, quadcoords, qw, qh, total)
	switcher.sheet = love.graphics.newImage(sheet)
	switcher.w = qw
	switcher.h = qh
	switcher.quads = {}
	local x = 1
	local y = 2
	for i = 1, total do
		table.insert(switcher.quads, love.graphics.newQuad(quadcoords[i][x], quadcoords[i][y], qw, qh, switcher.sheet:getDimensions()))
	end
end

function createswitches(x, y, lvl)
	local sw = {}
	sw.x = x
	sw.y = y
	sw.lvl = 1
	sw.on = false
	return sw
end

return switcher

--[[
function switcher.update(mx, my, ismouseclicked)
	local selected = -1
	for i = 1, #switcher.squares do
		if mx > switcher.squares[x] and mx < switcher.squares[x] + swidth and my > switcher.squares[y] and my < switcher.squares[y] + sheight then
			selected = i
			goto done
		end
	end
	::done::
end
]]