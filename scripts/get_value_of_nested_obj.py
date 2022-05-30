def get_value(object, key1):
    temp = object
    key_found = False
    try:
        while True:
            try:
                for key, value in temp.items():
                    temp = value
                    if key == key1:
                        key_found = True
                        break
            except Exception as e:
                break
            if key_found:
                break
    finally:
        print('value of provided key {} is: {}'.format(key1, temp))
        return temp

def traverse_nested_object(object, key, depth):
    temp = get_value(object, key)
    count = 0
    try:
        while True:
            try:
                if count < depth:
                    for key, value in temp.items():
                        temp = value
                    count = count + 1
                else:
                    break
            except Exception as e:
                break
    finally:
        return temp

def main():
    object = {"x":{"y":{"z":"a"}}}
    key = "z"
    depth = 0
    value = traverse_nested_object(object, key, depth)
    print("Value of depth is: {}".format(value))

if __name__ == '__main__':
    main()