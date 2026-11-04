.class public final Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;
.super Ljava/lang/Object;
.source "UploadOptions.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Builder"
.end annotation


# instance fields
.field private bucket:Ljava/lang/String;

.field private cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;

.field private listener:Lcom/amazonaws/mobileconnectors/s3/transferutility/TransferListener;

.field private metadata:Lcom/amazonaws/services/s3/model/ObjectMetadata;


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 68
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 69
    return-void
.end method

.method synthetic constructor <init>(Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$1;

    .line 62
    invoke-direct {p0}, Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;

    .line 62
    iget-object v0, p0, Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;->bucket:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$100(Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;)Lcom/amazonaws/services/s3/model/ObjectMetadata;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;

    .line 62
    iget-object v0, p0, Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;->metadata:Lcom/amazonaws/services/s3/model/ObjectMetadata;

    return-object v0
.end method

.method static synthetic access$200(Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;)Lcom/amazonaws/services/s3/model/CannedAccessControlList;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;

    .line 62
    iget-object v0, p0, Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;->cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    return-object v0
.end method

.method static synthetic access$300(Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;)Lcom/amazonaws/mobileconnectors/s3/transferutility/TransferListener;
    .locals 1
    .param p0, "x0"    # Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;

    .line 62
    iget-object v0, p0, Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;->listener:Lcom/amazonaws/mobileconnectors/s3/transferutility/TransferListener;

    return-object v0
.end method


# virtual methods
.method public bucket(Ljava/lang/String;)Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;
    .locals 0
    .param p1, "bucket"    # Ljava/lang/String;

    .line 78
    iput-object p1, p0, Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;->bucket:Ljava/lang/String;

    .line 79
    return-object p0
.end method

.method public build()Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions;
    .locals 1

    .line 120
    new-instance v0, Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions;

    invoke-direct {v0, p0}, Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions;-><init>(Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;)V

    return-object v0
.end method

.method public cannedAcl(Lcom/amazonaws/services/s3/model/CannedAccessControlList;)Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;
    .locals 0
    .param p1, "cannedAcl"    # Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    .line 100
    iput-object p1, p0, Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;->cannedAcl:Lcom/amazonaws/services/s3/model/CannedAccessControlList;

    .line 101
    return-object p0
.end method

.method public objectMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;)Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;
    .locals 0
    .param p1, "metadata"    # Lcom/amazonaws/services/s3/model/ObjectMetadata;

    .line 89
    iput-object p1, p0, Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;->metadata:Lcom/amazonaws/services/s3/model/ObjectMetadata;

    .line 90
    return-object p0
.end method

.method public transferListener(Lcom/amazonaws/mobileconnectors/s3/transferutility/TransferListener;)Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;
    .locals 0
    .param p1, "listener"    # Lcom/amazonaws/mobileconnectors/s3/transferutility/TransferListener;

    .line 111
    iput-object p1, p0, Lcom/amazonaws/mobileconnectors/s3/transferutility/UploadOptions$Builder;->listener:Lcom/amazonaws/mobileconnectors/s3/transferutility/TransferListener;

    .line 112
    return-object p0
.end method
