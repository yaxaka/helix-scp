ywms_shipment_thread = {
	[1] = {
		title = "Storage A",
		status = "Нет поставок",
		uid = nil,
		time = 0,
	},
	[2] = {
		title = "Storage B",
		status = "Нет поставок",
		uid = nil,
		time = 0,
	},
	[3] = {
		title = "Storage C",
		status = "Нет поставок",
		uid = nil,
		time = 0,
	},
}


function ywms_shipment_status(num)
	if num == 0 then
		return ywms_shipment_thread
	else
		return ywms_shipment_thread[num]
	end		
end

function ywms_shipment_start(storage, uid, count)
	local estimate_time = os.time() + count * 2
	local eta = estimate_time - os.time()
	local timer_name = storage .. "_shipmentprocess"

	ywms_shipment_thread[storage].status = "Доставка в пути"
	ywms_shipment_thread[storage].time = estimate_time
	ywms_shipment_thread[storage].uid = uid

	timer.Create(timer_name, eta, 1, function()
		ywms_EditCount(uid, count)
		ywms_shipment_thread[storage].status = "Нет поставок"
		ywms_shipment_thread[storage].time = 0
		ywms_shipment_thread[storage].uid = nil
	end)

	ymsg_d("Shipment of " .. uid .. " started. ETA: " .. eta)
end

function ywms_shipment_requestnew(storage, uid, count, user)
	if storage == nil or uid == nil or count == nil or user == nil then return end
	ymsg_d(user .. " shipment request " .. uid .. " to storage " .. storage .. " count " .. count)

	if ywms_shipment_status(storage).time ~= 0 then return false end

	ywms_shipment_start(storage, uid, count)

end