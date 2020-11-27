local switcher = {}

-- * para este metodo, a sheet precisa estar toda na horizontal *
-- shet: string do caminho da imagem com todos 'botoes' mais focus
-- quadcoords: tabela com as coordenas de cada 'botao' NA sheet
--             { {x1, y2}, {x2, y2}, ... }
-- qw: quad width
-- qh: quad height
-- total: quantidade de imagens NA sheet
function switcher.createsheetandquads(sheet, quadcoords, qw, qh, total)
	local x = 1
	local y = 2
	switcher.sheet = love.graphics.newImage(sheet)
	switcher.w = qw
	switcher.h = qh
	switcher.quads = {}
	for i = 1, total do
		table.insert(switcher.quads, love.graphics.newQuad(quadcoords[i][x], quadcoords[i][y], qw, qh, switcher.sheet:getDimensions()))
	end
end

-- coordinates: tabela com as coordenadas para render e colisao
--              { {x1, y1}, {x2, y2}, ... }
function switcher.createswitches(coordinates)
	local x = 1
	local y = 2
	switcher.switches = {}
	for i = 1, #coordinates do
		table.insert(switcher.switches, switcher.createswitch(coordinates[i][x], coordinates[i][y]))
	end
end

-- x: x no mapa
-- y: y no mapa
function switcher.createswitch(x, y)
	local sw = {}
	sw.x = x
	sw.y = y
	sw.id = 1
	sw.on = false
	return sw
end

-- mx: mouse x
-- my: mouse y
-- ismouseclicked: mouse clicked
-- upgrades: dado externo,tabela que contem os limites que os switches podem alcancar
--           antes de voltarem para 1
function switcher.update(mx, my, ismouseclicked, upgrades)
	local selected = -1
	for i = 1, #switcher.switches do
		switcher.switches[i].on = mx > switcher.switches[i].x and mx < switcher.switches[i].x + switcher.w and my > switcher.switches[i].y and my < switcher.switches[i].y + switcher.h
		if switcher.switches[i].on and ismouseclicked then
			selected = i
			goto done
		end
	end
	::done::
	if selected ~= -1 then
		switcher.checkswitch(selected,  upgrades[selected])
	end
end

-- selected: o id correstpondente ao switch selecionado dentro da tabela switches
-- limit: dado exterior, vindo de upgrade, representa o maximo que o switch pode ir naquele momento (antes
--        de voltar para 1)
function switcher.checkswitch(selected, limit)
	if switcher.switches[selected].id == limit then
		switcher.switches[selected].id = 1
	elseif switcher.switches[selected].id < limit then
		switcher.switches[selected].id = switcher.switches[selected].id + 1
	end
end

function switcher.draw()
	for i = 1, #switcher.switches do
		love.graphics.draw(switcher.sheet, switcher.quads[switcher.switches[i].id], switcher.switches[i].x, switcher.switches[i].y)
	end
end

return switcher
