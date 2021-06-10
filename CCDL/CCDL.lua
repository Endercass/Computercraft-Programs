local modem = peripheral.wrap("top")

modem.open(11)

args = {...}
if args[1] == "i" then
  packagetoinstall = args[2]
  packagefilename = "/CCDL/packages/" .. packagetoinstall .. ".lua"

  modem.transmit(10, 11, packagetoinstall)

  while true do
    event, side, frequency, replyFrequency, message, distance = os.pullEvent("modem_message")
  
    if message == "error" then
	  print("Error: Package '" .. packagetoinstall .. "' does not exist.")
	  return
    else
	  file = fs.open(packagefilename,"w")
	  file.write(message)
	  file.close()
	
	  print(packagetoinstall .. " Was successfully installed.")
	  return
    end
  end
end

if args[1] == "u" then
  packagetodelete = args[2]
  packagefilename = "/CCDL/packages/" .. packagetodelete .. ".lua"
  
  if fs.exists(packagefilename) then
    fs.delete(packagefilename)
	print("Package '" .. packagetodelete .. "' was successfully uninstalled.")
	return
  else
    print("Package '" .. packagetodelete .. "' is not installed.")
	return
  end
end

print("CCDL i <package> -- Install package")
print("CCDL u <package> -- Uninstall package")
