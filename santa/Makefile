MAIN=santa
EIFFEL_DIR=src/e

eiffel:
	cd ${EIFFEL_DIR}; ec -freeze -config ${MAIN}.ecf
	cd ${EIFFEL_DIR}/EIFGENs/${MAIN}/W_code; finish_freezing
	cp ${EIFFEL_DIR}/EIFGENs/${MAIN}/W_code/${MAIN} ./${MAIN}.out

