import boto3
import json

ec2 = boto3.resource('ec2')

def instanceID(instance):
    return instance.id


filters = [
    {
    'Name': 'instance-state-name',
    'Values': ['running']
}
]


# bootcamp_instances = [instance for instance in list(map(instanceID, ec2.instances.filter(Filters=filters)))  \
#                       if any(map(lambda i: 'Bootcamp' == i['Value'], ec2.Instance(instance).tags))]

bootcamp_instances = [instance for instance in list(map(instanceID, ec2.instances.all()))  \
                      if any(map(lambda i: 'Bootcamp' == i['Value'], ec2.Instance(instance).tags))]
for instance in bootcamp_instances:
    ec2.Instance(instance).stop()
    ec2.Instance(instance).wait_until_stopped()

    print(json.dumps({'instance_id': instance, 'tags': ec2.Instance(instance).tags, 'state': ec2.Instance(instance).state}, indent=4))

# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ec2.html#instance