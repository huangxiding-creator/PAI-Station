.class public Lcom/amazonaws/services/s3/model/SetBucketAclRequest;
.super Lcom/amazonaws/AmazonWebServiceRequest;
.source "SetBucketAclRequest.java"


# instance fields
.field private acl:Lcom/amazonaws/services/s3/model/AccessControlList;

.field private bucketName:Ljava/lang/String;

.field private cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;


# direct methods
.method public constructor <init>(Ljava/lang/String;Lcom/amazonaws/services/s3/model/AccessControlList;)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "acl"    # Lcom/amazonaws/services/s3/model/AccessControlList;

    .line 43
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 44
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketAclRequest;->bucketName:Ljava/lang/String;

    .line 45
    iput-object p2, p0, Lcom/amazonaws/services/s3/model/SetBucketAclRequest;->acl:Lcom/amazonaws/services/s3/model/AccessControlList;

    .line 46
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketAclRequest;->cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    .line 47
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Lcom/amazonaws/services/s3/model/CannedAccessControlList;)V
    .locals 1
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "acl"    # Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    .line 58
    invoke-direct {p0}, Lcom/amazonaws/AmazonWebServiceRequest;-><init>()V

    .line 59
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/SetBucketAclRequest;->bucketName:Ljava/lang/String;

    .line 60
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketAclRequest;->acl:Lcom/amazonaws/services/s3/model/AccessControlList;

    .line 61
    iput-object p2, p0, Lcom/amazonaws/services/s3/model/SetBucketAclRequest;->cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    .line 62
    return-void
.end method


# virtual methods
.method public getAcl()Lcom/amazonaws/services/s3/model/AccessControlList;
    .locals 1

    .line 84
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketAclRequest;->acl:Lcom/amazonaws/services/s3/model/AccessControlList;

    return-object v0
.end method

.method public getBucketName()Ljava/lang/String;
    .locals 1

    .line 72
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketAclRequest;->bucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getCannedAcl()Lcom/amazonaws/services/s3/model/CannedAccessControlList;
    .locals 1

    .line 96
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/SetBucketAclRequest;->cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    return-object v0
.end method
