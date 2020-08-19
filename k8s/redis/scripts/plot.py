from decimal import Decimal
import os
import sys
import subprocess
import pandas

a = pandas.DataFrame({'qps': [10,20,30,40], 'mode':['pba', 'pba', 'aof', 'aof'], 'data size': [32,512,32,512]})

count_line = 1

def collect_data(directory):
	data = {}
	for filename in os.listdir(directory):
		full_path = os.path.join(directory, filename)
		ops = subprocess.check_output("awk 'BEGIN{total=0.0}{if (NR<=%s) {total+=$2}}END{print total}' %s" % (count_line, full_path), shell=True)
		ops_queue = data.setdefault('ops', [])
		ops_queue.append(float(Decimal(ops)) / count_line)
		mode, data_size = filename.split('_')
		mode_queue = data.setdefault('mode', [])
		mode_queue.append(mode)
		data_size_queue = data.setdefault('data_size', [])
		data_size_queue.append(int(data_size))
	return data

if __name__ == '__main__':
    data = collect_data(sys.argv[1])
    data = pandas.DataFrame(data).pivot(index='data_size', columns='mode', values='ops')
    print data
    data.index.name = 'data size(bytes)'
    lines = data.sort_index().plot.line(title='pba, aof, volatile redis ops')
    fig = lines.get_figure()
    fig.savefig('test.png')
