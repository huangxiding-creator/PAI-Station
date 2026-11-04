.class public Lcom/amazonaws/services/s3/model/SetObjectAclRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "SetObjectAclRequest.java"

# interfaces
.implements Ljava/io/Serializable;


# instance fields
.field private final acl:Lcom/amazonaws/services/s3/model/AccessControlList;

.field private final bucketName:Ljava/lang/String;

.field private final cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;

.field private isRequesterPays:Z

.field private final key:Ljava/lang/String;

.field private final versionId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/model/AccessControlList;)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;
    .param p3, "acl"    # Lcom/amazonaws/services/s3/model/AccessControlList;

    .line 61
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 62
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->bucketName:Ljava/lang/String;

    .line 63
    iput-object p2, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->key:Ljava/lang/String;

    .line 64
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->versionId:Ljava/lang/String;

    .line 66
    iput-object p3, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->acl:Lcom/amazonaws/services/s3/model/AccessControlList;

    .line 67
    iput-object v0, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    .line 68
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/model/CannedAccessControlList;)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;
    .param p3, "acl"    # Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    .line 84
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 85
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->bucketName:Ljava/lang/String;

    .line 86
    iput-object p2, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->key:Ljava/lang/String;

    .line 87
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->versionId:Ljava/lang/String;

    .line 89
    iput-object v0, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->acl:Lcom/amazonaws/services/s3/model/AccessControlList;

    .line 90
    iput-object p3, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    .line 91
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/model/AccessControlList;)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;
    .param p3, "versionId"    # Ljava/lang/String;
    .param p4, "acl"    # Lcom/amazonaws/services/s3/model/AccessControlList;

    .line 109
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 110
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->bucketName:Ljava/lang/String;

    .line 111
    iput-object p2, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->key:Ljava/lang/String;

    .line 112
    iput-object p3, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->versionId:Ljava/lang/String;

    .line 114
    iput-object p4, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->acl:Lcom/amazonaws/services/s3/model/AccessControlList;

    .line 115
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    .line 116
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/model/CannedAccessControlList;)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;
    .param p3, "versionId"    # Ljava/lang/String;
    .param p4, "acl"    # Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    .line 134
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 135
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->bucketName:Ljava/lang/String;

    .line 136
    iput-object p2, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->key:Ljava/lang/String;

    .line 137
    iput-object p3, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->versionId:Ljava/lang/String;

    .line 139
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->acl:Lcom/amazonaws/services/s3/model/AccessControlList;

    .line 140
    iput-object p4, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    .line 141
    return-void
.end method


# virtual methods
.method public getAcl()Lcom/amazonaws/services/s3/model/AccessControlList;
    .locals 1

    .line 182
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->acl:Lcom/amazonaws/services/s3/model/AccessControlList;

    return-object v0
.end method

.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 151
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getCannedAcl()Lcom/amazonaws/services/s3/model/CannedAccessControlList;
    .locals 1

    .line 195
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    return-object v0
.end method

.method public getKey()Ljava/lang/String;
    .locals 1

    .line 160
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->key:Ljava/lang/String;

    return-object v0
.end method

.method public getVersionId()Ljava/lang/String;
    .locals 1

    .line 169
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->versionId:Ljava/lang/String;

    return-object v0
.end method

.method public isRequesterPays()Z
    .locals 1

    .line 215
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->isRequesterPays:Z

    return v0
.end method

.method public setRequesterPays(Z)V
    .locals 0
    .param p1, "isRequesterPays"    # Z

    .line 235
    iput-boolean p1, p0, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->isRequesterPays:Z

    .line 236
    return-void
.end method

.method public withRequesterPays(Z)Lcom/amazonaws/services/s3/model/SetObjectAclRequest;
    .locals 0
    .param p1, "isRequesterPays"    # Z

    .line 259
    invoke-virtual {p0, p1}, Lcom/amazonaws/services/s3/model/SetObjectAclRequest;->setRequesterPays(Z)V

    .line 260
    return-object p0
.end method
