module AccountsHelper
  def set_chart_data(operations)
    [{ name: 'A1', stack: 'stack1', data: [['t1', 1],['t2',2],['t3',3],['t4', 4]] }, { name: 'A2', stack: 'stack1', data: [['t1', 1],['t2',2],['t3',3],['t4', 4]] }, { name: 'B1', stack: 'stack2', data: [['t1', 1],['t2',2],['t3',3],['t4', 4]] }]
  end
end