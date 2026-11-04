.class public final Lcom/rokid/logger/RKLogUploader$client$2$1;
.super Ljava/lang/Object;
.source "RKLogUploader.kt"

# interfaces
.implements Lcom/amazonaws/auth/AWSCredentials;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/logger/RKLogUploader$client$2;->invoke()Lcom/amazonaws/services/s3/AmazonS3Client;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0013\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0008\u0010\u0002\u001a\u00020\u0003H\u0016J\u0008\u0010\u0004\u001a\u00020\u0003H\u0016\u00a8\u0006\u0005"
    }
    d2 = {
        "com/rokid/logger/RKLogUploader$client$2$1",
        "Lcom/amazonaws/auth/AWSCredentials;",
        "getAWSAccessKeyId",
        "",
        "getAWSSecretKey",
        "logger_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x5,
        0x1
    }
    xi = 0x30
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getAWSAccessKeyId()Ljava/lang/String;
    .locals 1

    .line 26
    const-string v0, "LINUJFMH70X6WOT4R6A0"

    return-object v0
.end method

.method public getAWSSecretKey()Ljava/lang/String;
    .locals 1

    .line 30
    const-string v0, "ucoc+ISx95OjPmpdS0mJII1bp0OcwuJzj2ln79dt"

    return-object v0
.end method
