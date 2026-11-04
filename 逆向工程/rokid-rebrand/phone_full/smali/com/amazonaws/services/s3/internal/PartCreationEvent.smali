.class public Lcom/amazonaws/services/s3/internal/PartCreationEvent;
.super Ljava/lang/Object;
.source "PartCreationEvent.java"


# instance fields
.field private final fileDeleteObserver:Lcom/amazonaws/services/s3/OnFileDelete;

.field private final isLastPart:Z

.field private final part:Ljava/io/File;

.field private final partNumber:I


# direct methods
.method constructor <init>(Ljava/io/File;IZLcom/amazonaws/services/s3/OnFileDelete;)V
    .locals 2
    .param p1, "part"    # Ljava/io/File;
    .param p2, "partNumber"    # I
    .param p3, "isLastPart"    # Z
    .param p4, "fileDeleteObserver"    # Lcom/amazonaws/services/s3/OnFileDelete;

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    if-eqz p1, :cond_0

    .line 34
    iput-object p1, p0, Lcom/amazonaws/services/s3/internal/PartCreationEvent;->part:Ljava/io/File;

    .line 35
    iput p2, p0, Lcom/amazonaws/services/s3/internal/PartCreationEvent;->partNumber:I

    .line 36
    iput-boolean p3, p0, Lcom/amazonaws/services/s3/internal/PartCreationEvent;->isLastPart:Z

    .line 37
    iput-object p4, p0, Lcom/amazonaws/services/s3/internal/PartCreationEvent;->fileDeleteObserver:Lcom/amazonaws/services/s3/OnFileDelete;

    .line 38
    return-void

    .line 33
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "part must not be specified"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public getFileDeleteObserver()Lcom/amazonaws/services/s3/OnFileDelete;
    .locals 1

    .line 61
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/PartCreationEvent;->fileDeleteObserver:Lcom/amazonaws/services/s3/OnFileDelete;

    return-object v0
.end method

.method public getPart()Ljava/io/File;
    .locals 1

    .line 45
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/PartCreationEvent;->part:Ljava/io/File;

    return-object v0
.end method

.method public getPartNumber()I
    .locals 1

    .line 49
    iget v0, p0, Lcom/amazonaws/services/s3/internal/PartCreationEvent;->partNumber:I

    return v0
.end method

.method public isLastPart()Z
    .locals 1

    .line 53
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/internal/PartCreationEvent;->isLastPart:Z

    return v0
.end method
