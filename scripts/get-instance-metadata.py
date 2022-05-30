from googleapiclient import discovery

def get_instance_metadata(project_id, zone, instance_name, metadata_parameter):
    compute_service = discovery.build('compute', 'v1')
    compute_request = compute_service.instances().get(project=project_id, zone=zone, instance=instance_name)
    try:
        response = compute_request.execute()
        print(response)
        instance_metadata = response.get('metadata')
    except Exception as e:
        print(e)
    finally:
        return instance_metadata, instance_metadata.get(metadata_parameter)

def main():
    project_id = ""
    zone = ""
    instance_name = ""
    metadata_parameter = ""
    metadata, parameter_value = get_instance_metadata(project_id, zone, instance_name, metadata_parameter)

if __name__ == '__main__':
    main()