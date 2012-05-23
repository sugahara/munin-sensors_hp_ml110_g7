
##CONFIGURE HERE##
ipmitool_path = "/usr/bin/ipmitool" #ipmitool path (which ipmitool)

##################

sensors = Hash.new

io = IO.popen("#{ipmitool_path} sdr")
io.each do |line|
  if line.index("degrees")
    key = line.split("|")[0].strip
    value = line.split("|")[1].strip.split(" ")[0]
    sensors[key] = value
  end
end


if ARGV[0] == "config"
  print "graph_title Server Temperature\n"
  print "graph_args --base 1000 -l 0\n"
  print "graph_vlabel temp\n"
  print "graph_scale no\n"
  print "graph_category sensors\n"
  
  sensors.each do |key, value|
    print "#{key}.label #{key}\n"
  end
  
  print "graph_info system Temp.\n"
  exit 0

elsif ARGV[0] == "autoconf"
  print "yes\n"
  exit 0

else
  sensors.each do |key, value|
    print "#{key}.value #{value}\n"
  end
  
end

