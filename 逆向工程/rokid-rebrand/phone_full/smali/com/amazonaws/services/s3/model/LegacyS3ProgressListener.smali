.class public Lcom/amazonaws/services/s3/model/LegacyS3ProgressListener;
.super Ljava/lang/Object;
.source "LegacyS3ProgressListener.java"

# interfaces
.implements Lcom/amazonaws/event/ProgressListener;


# instance fields
.field private final listener:Lcom/amazonaws/services/s3/model/ProgressListener;


# direct methods
.method public constructor <init>(Lcom/amazonaws/services/s3/model/ProgressListener;)V
    .locals 0
    .param p1, "listener"    # Lcom/amazonaws/services/s3/model/ProgressListener;

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 32
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/LegacyS3ProgressListener;->listener:Lcom/amazonaws/services/s3/model/ProgressListener;

    .line 33
    return-void
.end method

.method private transform(Lcom/amazonaws/event/ProgressEvent;)Lcom/amazonaws/services/s3/model/ProgressEvent;
    .locals 4
    .param p1, "event"    # Lcom/amazonaws/event/ProgressEvent;

    .line 50
    new-instance v0, Lcom/amazonaws/services/s3/model/ProgressEvent;

    invoke-virtual {p1}, Lcom/amazonaws/event/ProgressEvent;->getEventCode()I

    move-result v1

    invoke-virtual {p1}, Lcom/amazonaws/event/ProgressEvent;->getBytesTransferred()J

    move-result-wide v2

    invoke-direct {v0, v1, v2, v3}, Lcom/amazonaws/services/s3/model/ProgressEvent;-><init>(IJ)V

    return-object v0
.end method


# virtual methods
.method public progressChanged(Lcom/amazonaws/event/ProgressEvent;)V
    .locals 2
    .param p1, "progressEvent"    # Lcom/amazonaws/event/ProgressEvent;

    .line 43
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/LegacyS3ProgressListener;->listener:Lcom/amazonaws/services/s3/model/ProgressListener;

    if-nez v0, :cond_0

    .line 44
    return-void

    .line 45
    :cond_0
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/LegacyS3ProgressListener;->listener:Lcom/amazonaws/services/s3/model/ProgressListener;

    invoke-direct {p0, p1}, Lcom/amazonaws/services/s3/model/LegacyS3ProgressListener;->transform(Lcom/amazonaws/event/ProgressEvent;)Lcom/amazonaws/services/s3/model/ProgressEvent;

    move-result-object v1

    invoke-interface {v0, v1}, Lcom/amazonaws/services/s3/model/ProgressListener;->progressChanged(Lcom/amazonaws/services/s3/model/ProgressEvent;)V

    .line 46
    return-void
.end method

.method public unwrap()Lcom/amazonaws/services/s3/model/ProgressListener;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/LegacyS3ProgressListener;->listener:Lcom/amazonaws/services/s3/model/ProgressListener;

    return-object v0
.end method
