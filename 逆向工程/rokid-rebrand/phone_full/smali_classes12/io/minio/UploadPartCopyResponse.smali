.class public Lio/minio/UploadPartCopyResponse;
.super Lio/minio/GenericResponse;
.source "UploadPartCopyResponse.java"


# instance fields
.field private partNumber:I

.field private result:Lio/minio/messages/CopyPartResult;

.field private uploadId:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILio/minio/messages/CopyPartResult;)V
    .locals 0
    .param p1, "headers"    # Lokhttp3/Headers;
    .param p2, "bucket"    # Ljava/lang/String;
    .param p3, "region"    # Ljava/lang/String;
    .param p4, "object"    # Ljava/lang/String;
    .param p5, "uploadId"    # Ljava/lang/String;
    .param p6, "partNumber"    # I
    .param p7, "result"    # Lio/minio/messages/CopyPartResult;

    .line 36
    invoke-direct {p0, p1, p2, p3, p4}, Lio/minio/GenericResponse;-><init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    .line 37
    iput-object p5, p0, Lio/minio/UploadPartCopyResponse;->uploadId:Ljava/lang/String;

    .line 38
    iput p6, p0, Lio/minio/UploadPartCopyResponse;->partNumber:I

    .line 39
    iput-object p7, p0, Lio/minio/UploadPartCopyResponse;->result:Lio/minio/messages/CopyPartResult;

    .line 40
    return-void
.end method


# virtual methods
.method public partNumber()I
    .locals 1

    .line 47
    iget v0, p0, Lio/minio/UploadPartCopyResponse;->partNumber:I

    return v0
.end method

.method public result()Lio/minio/messages/CopyPartResult;
    .locals 1

    .line 51
    iget-object v0, p0, Lio/minio/UploadPartCopyResponse;->result:Lio/minio/messages/CopyPartResult;

    return-object v0
.end method

.method public uploadId()Ljava/lang/String;
    .locals 1

    .line 43
    iget-object v0, p0, Lio/minio/UploadPartCopyResponse;->uploadId:Ljava/lang/String;

    return-object v0
.end method
