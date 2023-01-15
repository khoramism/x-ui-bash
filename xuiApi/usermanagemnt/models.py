from django.db import models



class InboundClientIps(models.Model):
    id = models.AutoField(primary_key=True)
    client_email = models.TextField()
    ips = models.TextField()

    class Meta:
        db_table = 'inbound_client_ips'


class Inbounds(models.Model):
    id = models.AutoField(primary_key=True)
    user_id = models.IntegerField()
    up = models.IntegerField()
    down = models.IntegerField()
    total = models.IntegerField()
    remark = models.TextField()
    enable = models.TextField()  # This field type is a guess.
    expiry_time = models.IntegerField()
    listen = models.TextField()
    port = models.IntegerField()
    protocol = models.TextField()
    settings = models.TextField()
    stream_settings = models.TextField()
    tag = models.TextField()
    sniffing = models.TextField()

    class Meta:
        
        db_table = 'inbounds'


class Settings(models.Model):
    id = models.AutoField(primary_key=True)
    key = models.TextField()
    value = models.TextField()

    class Meta:
        
        db_table = 'settings'


class Users(models.Model):
    id = models.AutoField(primary_key=True)
    username = models.TextField()
    password = models.TextField()

    class Meta:
        
        db_table = 'users'

class ClientTraffics(models.Model):
    id = models.AutoField(primary_key=True)
    inbound_id = models.TextField()
    enable = models.TextField()
    email = models.TextField()
    up = models.TextField()
    down = models.TextField()
    expiry_time = models.TextField()
    total = models.TextField()

    class Meta:    
        db_table = 'client_traffics'

