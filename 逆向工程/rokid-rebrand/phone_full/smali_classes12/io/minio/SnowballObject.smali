.class public Lio/minio/SnowballObject;
.super Ljava/lang/Object;
.source "SnowballObject.java"


# instance fields
.field private filename:Ljava/lang/String;

.field private modificationTime:Ljava/time/ZonedDateTime;

.field private name:Ljava/lang/String;

.field private size:J

.field private stream:Ljava/io/InputStream;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/io/InputStream;JLjava/time/ZonedDateTime;)V
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "stream"    # Ljava/io/InputStream;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p3, "size"    # J
    .param p5, "modificationTime"    # Ljava/time/ZonedDateTime;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation
    .end param

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 39
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    .line 40
    const-string v0, "/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, p1

    :goto_0
    iput-object v0, p0, Lio/minio/SnowballObject;->name:Ljava/lang/String;

    .line 41
    const-string/jumbo v0, "stream must not be null"

    invoke-static {p2, v0}, Ljava/util/Objects;->requireNonNull(Ljava/lang/Object;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/io/InputStream;

    iput-object v0, p0, Lio/minio/SnowballObject;->stream:Ljava/io/InputStream;

    .line 42
    const-wide/16 v0, 0x0

    cmp-long v0, p3, v0

    if-ltz v0, :cond_1

    .line 43
    iput-wide p3, p0, Lio/minio/SnowballObject;->size:J

    .line 44
    iput-object p5, p0, Lio/minio/SnowballObject;->modificationTime:Ljava/time/ZonedDateTime;

    .line 45
    return-void

    .line 42
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string/jumbo v1, "size cannot be negative value"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 39
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "name must be provided"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "name"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param
    .param p2, "filename"    # Ljava/lang/String;
        .annotation runtime Ljavax/annotation/Nonnull;
        .end annotation
    .end param

    .line 47
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 48
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_2

    .line 49
    const-string v0, "/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    invoke-virtual {p1, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    move-object v0, p1

    :goto_0
    iput-object v0, p0, Lio/minio/SnowballObject;->name:Ljava/lang/String;

    .line 50
    if-eqz p2, :cond_1

    invoke-virtual {p2}, Ljava/lang/String;->isEmpty()Z

    move-result v0

    if-nez v0, :cond_1

    .line 53
    iput-object p2, p0, Lio/minio/SnowballObject;->filename:Ljava/lang/String;

    .line 54
    return-void

    .line 51
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "filename must be provided"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 48
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "name must be provided"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public filename()Ljava/lang/String;
    .locals 1

    .line 69
    iget-object v0, p0, Lio/minio/SnowballObject;->filename:Ljava/lang/String;

    return-object v0
.end method

.method public modificationTime()Ljava/time/ZonedDateTime;
    .locals 1

    .line 73
    iget-object v0, p0, Lio/minio/SnowballObject;->modificationTime:Ljava/time/ZonedDateTime;

    return-object v0
.end method

.method public name()Ljava/lang/String;
    .locals 1

    .line 57
    iget-object v0, p0, Lio/minio/SnowballObject;->name:Ljava/lang/String;

    return-object v0
.end method

.method public size()J
    .locals 2

    .line 65
    iget-wide v0, p0, Lio/minio/SnowballObject;->size:J

    return-wide v0
.end method

.method public stream()Ljava/io/InputStream;
    .locals 1

    .line 61
    iget-object v0, p0, Lio/minio/SnowballObject;->stream:Ljava/io/InputStream;

    return-object v0
.end method
