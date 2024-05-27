print("Before continuing, make sure your 2 proxmox hosts are already in a cluster")


function yes_or_no()
	local answer
	repeat
		io.write("Please answer with y for yes, or n for no: ")
		io.flush()
		answer=io.read()
	until answer=="y" or answer=="n"

	if answer == "y" then
		return true
	else
		return false
	end
end

function get_input(question)
	io.write(question)
	io.flush()
	return io.read()
end

function execute_return(command)
	local fp = assert(io.popen(command, "r"))
	local output = fp:read("*all")
	fp:close()
	return(output)
end


print("Before continuing, make sure your 2 proxmox hosts are already in a cluster")
get_input("Press enter to continue")
print("")
local qdevip = get_input("Please enter the IP of the device docker: ")
local qdevportp = get_input("Please enter ssh port for the qdevice instance (default 2222): ")
local node1ip = get_input("Please enter the IP of the first proxmox node: ")
local node2ip = get_input("Please enter the IP of the second proxmox node: ")


