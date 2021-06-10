local modem = peripheral.wrap("top")
modem.open(10)
 	

while true do
  event, side, frequency, replyFrequency, message, distance = os.pullEvent("modem_message")
  
  packagefilename = "/CCDL/packages/" .. message .. ".lua"
  file = fs.open(packagefilename,"r")
  
  if file == nil then
	modem.transmit(replyFrequency, 10, "error")
	print("Client requested unknown program.")
  else
	modem.transmit(replyFrequency, 10, file.readAll())
	print(message .. " Was sent.")
  end
end
