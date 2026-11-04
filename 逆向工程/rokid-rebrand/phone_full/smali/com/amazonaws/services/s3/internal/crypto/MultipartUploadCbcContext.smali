.class final Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCbcContext;
.super Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;
.source "MultipartUploadCbcContext.java"


# annotations
.annotation runtime Ljava/lang/Deprecated;
.end annotation


# instance fields
.field private nextIV:[B


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)V
    .locals 0
    .param p1, "bucketName"    # Ljava/lang/String;
    .param p2, "key"    # Ljava/lang/String;
    .param p3, "cekMaterial"    # Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;

    .line 27
    invoke-direct {p0, p1, p2, p3}, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCryptoContext;-><init>(Ljava/lang/String;Ljava/lang/String;Lcom/amazonaws/services/s3/internal/crypto/ContentCryptoMaterial;)V

    .line 28
    return-void
.end method


# virtual methods
.method public getNextInitializationVector()[B
    .locals 1

    .line 36
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCbcContext;->nextIV:[B

    return-object v0
.end method

.method public setNextInitializationVector([B)V
    .locals 0
    .param p1, "nextIV"    # [B

    .line 32
    iput-object p1, p0, Lcom/amazonaws/services/s3/internal/crypto/MultipartUploadCbcContext;->nextIV:[B

    .line 33
    return-void
.end method
