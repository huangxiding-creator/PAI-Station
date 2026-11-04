.class public Lio/minio/GenericResponse;
.super Ljava/lang/Object;
.source "GenericResponse.java"


# instance fields
.field private bucket:Ljava/lang/String;

.field private headers:Lokhttp3/Headers;

.field private object:Ljava/lang/String;

.field private region:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lokhttp3/Headers;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "headers"    # Lokhttp3/Headers;
    .param p2, "bucket"    # Ljava/lang/String;
    .param p3, "region"    # Ljava/lang/String;
    .param p4, "object"    # Ljava/lang/String;

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 29
    iput-object p1, p0, Lio/minio/GenericResponse;->headers:Lokhttp3/Headers;

    .line 30
    iput-object p2, p0, Lio/minio/GenericResponse;->bucket:Ljava/lang/String;

    .line 31
    iput-object p3, p0, Lio/minio/GenericResponse;->region:Ljava/lang/String;

    .line 32
    iput-object p4, p0, Lio/minio/GenericResponse;->object:Ljava/lang/String;

    .line 33
    return-void
.end method


# virtual methods
.method public bucket()Ljava/lang/String;
    .locals 1

    .line 40
    iget-object v0, p0, Lio/minio/GenericResponse;->bucket:Ljava/lang/String;

    return-object v0
.end method

.method public headers()Lokhttp3/Headers;
    .locals 1

    .line 36
    iget-object v0, p0, Lio/minio/GenericResponse;->headers:Lokhttp3/Headers;

    return-object v0
.end method

.method public object()Ljava/lang/String;
    .locals 1

    .line 48
    iget-object v0, p0, Lio/minio/GenericResponse;->object:Ljava/lang/String;

    return-object v0
.end method

.method public region()Ljava/lang/String;
    .locals 1

    .line 44
    iget-object v0, p0, Lio/minio/GenericResponse;->region:Ljava/lang/String;

    return-object v0
.end method
