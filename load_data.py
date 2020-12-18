import yaml

def yaml_loader(filepath):
    """Loads a yaml file"""
    with open(filepath, "r") as file_descriptor:
        data = yaml.safe_load(file_descriptor)
    return data

yaml_data = yaml_loader('bb_temp.yml')
tuples_to_insert = (str(list(zip(yaml_data['months'],yaml_data['max'],yaml_data['min'],yaml_data['avg'])))[1:-1])
tuples_to_insert = tuples_to_insert.replace("None","NULL")
insert_sql = "INSERT INTO  `temp_bb` (`Months`, `Max temperature`, `Min temperature`, `Avg temperature`) VALUES"
print(insert_sql + tuples_to_insert)