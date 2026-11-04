.class final Lcom/rokid/logger/RKLogUploader$client$2;
.super Lkotlin/jvm/internal/Lambda;
.source "RKLogUploader.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/logger/RKLogUploader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function0<",
        "Lcom/amazonaws/services/s3/AmazonS3Client;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0006\n\u0000\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001H\n"
    }
    d2 = {
        "<anonymous>",
        "Lcom/amazonaws/services/s3/AmazonS3Client;"
    }
    k = 0x3
    mv = {
        0x1,
        0x5,
        0x1
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/logger/RKLogUploader$client$2;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/logger/RKLogUploader$client$2;

    invoke-direct {v0}, Lcom/rokid/logger/RKLogUploader$client$2;-><init>()V

    sput-object v0, Lcom/rokid/logger/RKLogUploader$client$2;->INSTANCE:Lcom/rokid/logger/RKLogUploader$client$2;

    return-void
.end method

.method constructor <init>()V
    .locals 1

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public final invoke()Lcom/amazonaws/services/s3/AmazonS3Client;
    .locals 5

    .line 24
    new-instance v0, Lcom/amazonaws/services/s3/AmazonS3Client;

    new-instance v1, Lcom/rokid/logger/RKLogUploader$client$2$1;

    invoke-direct {v1}, Lcom/rokid/logger/RKLogUploader$client$2$1;-><init>()V

    check-cast v1, Lcom/amazonaws/auth/AWSCredentials;

    .line 32
    sget-object v2, Lcom/amazonaws/regions/Regions;->CN_NORTH_1:Lcom/amazonaws/regions/Regions;

    invoke-static {v2}, Lcom/amazonaws/regions/Region;->getRegion(Lcom/amazonaws/regions/Regions;)Lcom/amazonaws/regions/Region;

    move-result-object v2

    .line 24
    invoke-direct {v0, v1, v2}, Lcom/amazonaws/services/s3/AmazonS3Client;-><init>(Lcom/amazonaws/auth/AWSCredentials;Lcom/amazonaws/regions/Region;)V

    .line 32
    move-object v1, v0

    .local v1, "$this$invoke_u24lambda_u2d0":Lcom/amazonaws/services/s3/AmazonS3Client;
    const/4 v2, 0x0

    .line 33
    .local v2, "$i$a$-apply-RKLogUploader$client$2$2":I
    const-string v3, "https://file-openar.rokid.com:443"

    invoke-virtual {v1, v3}, Lcom/amazonaws/services/s3/AmazonS3Client;->setEndpoint(Ljava/lang/String;)V

    .line 34
    invoke-static {}, Lcom/amazonaws/services/s3/S3ClientOptions;->builder()Lcom/amazonaws/services/s3/S3ClientOptions$Builder;

    move-result-object v3

    const/4 v4, 0x1

    invoke-virtual {v3, v4}, Lcom/amazonaws/services/s3/S3ClientOptions$Builder;->setPathStyleAccess(Z)Lcom/amazonaws/services/s3/S3ClientOptions$Builder;

    move-result-object v3

    invoke-virtual {v3}, Lcom/amazonaws/services/s3/S3ClientOptions$Builder;->build()Lcom/amazonaws/services/s3/S3ClientOptions;

    move-result-object v3

    invoke-virtual {v1, v3}, Lcom/amazonaws/services/s3/AmazonS3Client;->setS3ClientOptions(Lcom/amazonaws/services/s3/S3ClientOptions;)V

    .line 36
    nop

    .line 32
    .end local v1    # "$this$invoke_u24lambda_u2d0":Lcom/amazonaws/services/s3/AmazonS3Client;
    .end local v2    # "$i$a$-apply-RKLogUploader$client$2$2":I
    return-object v0
.end method

.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 23
    invoke-virtual {p0}, Lcom/rokid/logger/RKLogUploader$client$2;->invoke()Lcom/amazonaws/services/s3/AmazonS3Client;

    move-result-object v0

    return-object v0
.end method
