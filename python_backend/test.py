import ipdb
import requests
import json
import os
import datetime
# headers = {
#     "X-API-Token": "77a6591c188868b792acc403ea6b264961b751b9c3816d1ac7b4852290364d25"}

# url = 'https://www.showclix.com/rest.api/Seller/17103/events'

# res = requests.get(url, headers=headers)
# data = json.loads(res.text)
# print(data)
# os.chdir(os.getcwd())
# with open('output.json', 'w') as f:
#     json.dump(data, f, indent=4)

raw_data = {"22319585": {"level_id": "22319585", "event_id": "6770694", "price": "15.00", "min_price": None, "level": "Mens General Admission", "active": "1", "description": "", "parent_id": None, "position": None, "increment_by": None, "transaction_limit": "10", "ticket_layout_id": None, "upsell_price": None, "discount_type": "none", "discount_val": "0.00"}, "22319586": {"level_id": "22319586", "event_id": "6770694", "price": "0.00", "min_price": None, "level": "Ladies Free ", "active": "1", "description": "", "parent_id": None, "position": None, "increment_by": None,
                                                                                                                                                                                                                                                                                                                                                                                       "transaction_limit": "10", "ticket_layout_id": None, "upsell_price": None, "discount_type": "none", "discount_val": "0.00"}, "22809906": {"level_id": "22809906", "event_id": "6770694", "price": "0.00", "min_price": None, "level": "Ladies Night:  Free Champagne Bottle", "active": "0", "description": "This ticket includes a champagne bottle before 10pm. Party must include 4 or more ladies.", "parent_id": None, "position": None, "increment_by": None, "transaction_limit": "10", "ticket_layout_id": None, "upsell_price": None, "discount_type": "none", "discount_val": "0.00"}}

# for key in raw_data:
#     print(raw_data[key]['price'])
#     print(raw_data[key]['level'])


with open('output.json', 'r') as f:
    data = json.load(f)

new_events = []
for item in data:
    latest_date = datetime.datetime.now()
    if data[item]['event_end'] is None:
        _date = datetime.datetime.strptime(
            data[item]['event_start'], "%Y-%m-%d %H:%M:%S")
    else:
        _date = datetime.datetime.strptime(
            data[item]['event_end'], "%Y-%m-%d %H:%M:%S")
    if (_date - latest_date).days >= 0:
        print(data[item]['event'])
        if not data[item]['image_url'] == None:
            for event in new_events:
                if event['image_url'] == data[item]['image_url']:
                    break
            else:
                new_events.append(data[item])

# new_events.extend(weekly_events)
print(len(new_events))
data = {'events': new_events}
with open('new_events.json', 'w') as f:
    data = json.dump(data, f, indent=4)

ipdb.sset_trace()
