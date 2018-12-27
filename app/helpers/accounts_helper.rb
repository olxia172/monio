module AccountsHelper
  def set_chart_data(operations)

    [
      { name: 'Zaplanowane', stack: 'stack2', data: [['t1', 1],['t2',2],['t3',3],['t4', 4]] },
      { name: 'Zaplacone', stack: 'stack1', data: [['t1', 1],['t2',2],['t3',3],['t4', 4]] },
      { name: 'Do zaplacenia', stack: 'stack1', data: [['t1', 1],['t2',2],['t3',3],['t4', 4]] }
    ]
  end
end