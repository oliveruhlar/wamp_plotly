import numpy as np
import plotly.graph_objects as go
import plotly
import pymysql
from prettytable import PrettyTable


db = pymysql.connect(host="localhost", port=3308, user="root", password="",database="myfirstdb" )
cursor = db.cursor()
sql_select = "SELECT * FROM temp_bb"
cursor.execute(sql_select)
records = cursor.fetchall()
result_table = PrettyTable()
result_table.field_names = ["Month","Max C°","Min C°", "Avg C°"]
for row in records:
    result_table.add_row(row)
print(result_table)

sql_select_months = "SELECT Months FROM temp_bb"
cursor.execute(sql_select_months)
months = [i[0] for i in cursor.fetchall()]


sql_select_max = "SELECT `Max temperature` FROM temp_bb"
cursor.execute(sql_select_max)
max_t = [i[0] for i in cursor.fetchall()]

sql_select_min = "SELECT `Min temperature` FROM temp_bb"
cursor.execute(sql_select_min)
min_t = [i[0] for i in cursor.fetchall()]


sql_select_avg = "SELECT `Avg temperature` FROM temp_bb"
cursor.execute(sql_select_avg)
avg_t = [i[0] for i in cursor.fetchall()]

    

fig = go.Figure()
fig.add_trace(go.Scatter(x=months, y=min_t,name='Min C°',connectgaps=True))
fig.add_trace(go.Scatter(x=months, y=max_t, name='Max C°', ))



fig.add_trace(go.Scatter(x=months, y=avg_t, name='Avg C°'))

fig.update_layout(title='Maximum, Average and minimum Temperatures in Banska Bystrica',
                   xaxis_title='Months',
                   yaxis_title='Temperature (degrees C°)',
                   modebar=dict(color='cyan'))
fig.update_traces(dx=10.0,dy=10.0)
fig.show()