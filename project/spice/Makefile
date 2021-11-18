
plt=python3 ../../py/plot.py

pixSens:
	${MAKE} ngspice	 TB=pixelSensor_tb

pixSensCopy:
	${MAKE} ngspice TB=pixelSensor_tb_copy

ngspice:
	ngspice -a ${TB}.cir

test:
	${MAKE} ngspice TB=test

aim:
	-rm ${TB}.log
	-rm ${TB}.csv
	aimspice ${TB}.cir -o csv | tee ${TB}.sim
	@cat ${TB}.sim | perl -ne "if(m/error/i){system('cat ${TB}.log'); exit 1;}"

