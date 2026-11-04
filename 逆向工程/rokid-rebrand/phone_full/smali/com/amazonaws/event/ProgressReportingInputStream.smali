.class public Lcom/amazonaws/event/ProgressReportingInputStream;
.super Lcom/amazonaws/internal/SdkFilterInputStream;
.source "ProgressReportingInputStream.java"


# static fields
.field private static final BYTES_IN_KB:I = 0x400

.field private static final THRESHOLD_IN_KB:I = 0x8


# instance fields
.field private fireCompletedEvent:Z

.field private final listenerCallbackExecutor:Lcom/amazonaws/event/ProgressListenerCallbackExecutor;

.field private notificationThreshold:I

.field private unnotifiedByteCount:I


# direct methods
.method public constructor <init>(Ljava/io/InputStream;Lcom/amazonaws/event/ProgressListenerCallbackExecutor;)V
    .locals 1
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "listenerCallbackExecutor"    # Lcom/amazonaws/event/ProgressListenerCallbackExecutor;

    .line 71
    invoke-direct {p0, p1}, Lcom/amazonaws/internal/SdkFilterInputStream;-><init>(Ljava/io/InputStream;)V

    .line 42
    const/16 v0, 0x2000

    iput v0, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->notificationThreshold:I

    .line 72
    iput-object p2, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->listenerCallbackExecutor:Lcom/amazonaws/event/ProgressListenerCallbackExecutor;

    .line 73
    return-void
.end method

.method private notify(I)V
    .locals 4
    .param p1, "bytesRead"    # I

    .line 160
    iget v0, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->unnotifiedByteCount:I

    add-int/2addr v0, p1

    iput v0, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->unnotifiedByteCount:I

    .line 162
    iget v0, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->unnotifiedByteCount:I

    iget v1, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->notificationThreshold:I

    if-lt v0, v1, :cond_0

    .line 163
    iget-object v0, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->listenerCallbackExecutor:Lcom/amazonaws/event/ProgressListenerCallbackExecutor;

    new-instance v1, Lcom/amazonaws/event/ProgressEvent;

    iget v2, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->unnotifiedByteCount:I

    int-to-long v2, v2

    invoke-direct {v1, v2, v3}, Lcom/amazonaws/event/ProgressEvent;-><init>(J)V

    invoke-virtual {v0, v1}, Lcom/amazonaws/event/ProgressListenerCallbackExecutor;->progressChanged(Lcom/amazonaws/event/ProgressEvent;)V

    .line 164
    const/4 v0, 0x0

    iput v0, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->unnotifiedByteCount:I

    .line 166
    :cond_0
    return-void
.end method

.method private notifyCompleted()V
    .locals 3

    .line 150
    iget-boolean v0, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->fireCompletedEvent:Z

    if-nez v0, :cond_0

    .line 151
    return-void

    .line 153
    :cond_0
    new-instance v0, Lcom/amazonaws/event/ProgressEvent;

    iget v1, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->unnotifiedByteCount:I

    int-to-long v1, v1

    invoke-direct {v0, v1, v2}, Lcom/amazonaws/event/ProgressEvent;-><init>(J)V

    .line 154
    .local v0, "event":Lcom/amazonaws/event/ProgressEvent;
    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Lcom/amazonaws/event/ProgressEvent;->setEventCode(I)V

    .line 155
    const/4 v1, 0x0

    iput v1, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->unnotifiedByteCount:I

    .line 156
    iget-object v1, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->listenerCallbackExecutor:Lcom/amazonaws/event/ProgressListenerCallbackExecutor;

    invoke-virtual {v1, v0}, Lcom/amazonaws/event/ProgressListenerCallbackExecutor;->progressChanged(Lcom/amazonaws/event/ProgressEvent;)V

    .line 157
    return-void
.end method


# virtual methods
.method public close()V
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 142
    iget v0, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->unnotifiedByteCount:I

    if-lez v0, :cond_0

    .line 143
    iget-object v0, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->listenerCallbackExecutor:Lcom/amazonaws/event/ProgressListenerCallbackExecutor;

    new-instance v1, Lcom/amazonaws/event/ProgressEvent;

    iget v2, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->unnotifiedByteCount:I

    int-to-long v2, v2

    invoke-direct {v1, v2, v3}, Lcom/amazonaws/event/ProgressEvent;-><init>(J)V

    invoke-virtual {v0, v1}, Lcom/amazonaws/event/ProgressListenerCallbackExecutor;->progressChanged(Lcom/amazonaws/event/ProgressEvent;)V

    .line 144
    const/4 v0, 0x0

    iput v0, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->unnotifiedByteCount:I

    .line 146
    :cond_0
    invoke-super {p0}, Lcom/amazonaws/internal/SdkFilterInputStream;->close()V

    .line 147
    return-void
.end method

.method public getFireCompletedEvent()Z
    .locals 1

    .line 107
    iget-boolean v0, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->fireCompletedEvent:Z

    return v0
.end method

.method public read()I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 112
    invoke-super {p0}, Lcom/amazonaws/internal/SdkFilterInputStream;->read()I

    move-result v0

    .line 113
    .local v0, "data":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 114
    invoke-direct {p0}, Lcom/amazonaws/event/ProgressReportingInputStream;->notifyCompleted()V

    goto :goto_0

    .line 116
    :cond_0
    const/4 v1, 0x1

    invoke-direct {p0, v1}, Lcom/amazonaws/event/ProgressReportingInputStream;->notify(I)V

    .line 118
    :goto_0
    return v0
.end method

.method public read([BII)I
    .locals 2
    .param p1, "b"    # [B
    .param p2, "off"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 132
    invoke-super {p0, p1, p2, p3}, Lcom/amazonaws/internal/SdkFilterInputStream;->read([BII)I

    move-result v0

    .line 133
    .local v0, "bytesRead":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 134
    invoke-direct {p0}, Lcom/amazonaws/event/ProgressReportingInputStream;->notifyCompleted()V

    .line 135
    :cond_0
    if-eq v0, v1, :cond_1

    .line 136
    invoke-direct {p0, v0}, Lcom/amazonaws/event/ProgressReportingInputStream;->notify(I)V

    .line 137
    :cond_1
    return v0
.end method

.method public reset()V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 123
    invoke-super {p0}, Lcom/amazonaws/internal/SdkFilterInputStream;->reset()V

    .line 124
    new-instance v0, Lcom/amazonaws/event/ProgressEvent;

    iget v1, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->unnotifiedByteCount:I

    int-to-long v1, v1

    invoke-direct {v0, v1, v2}, Lcom/amazonaws/event/ProgressEvent;-><init>(J)V

    .line 125
    .local v0, "event":Lcom/amazonaws/event/ProgressEvent;
    const/16 v1, 0x20

    invoke-virtual {v0, v1}, Lcom/amazonaws/event/ProgressEvent;->setEventCode(I)V

    .line 126
    iget-object v1, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->listenerCallbackExecutor:Lcom/amazonaws/event/ProgressListenerCallbackExecutor;

    invoke-virtual {v1, v0}, Lcom/amazonaws/event/ProgressListenerCallbackExecutor;->progressChanged(Lcom/amazonaws/event/ProgressEvent;)V

    .line 127
    const/4 v1, 0x0

    iput v1, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->unnotifiedByteCount:I

    .line 128
    return-void
.end method

.method public setFireCompletedEvent(Z)V
    .locals 0
    .param p1, "fireCompletedEvent"    # Z

    .line 95
    iput-boolean p1, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->fireCompletedEvent:Z

    .line 96
    return-void
.end method

.method public setNotificationThreshold(I)V
    .locals 1
    .param p1, "threshold"    # I

    .line 83
    mul-int/lit16 v0, p1, 0x400

    iput v0, p0, Lcom/amazonaws/event/ProgressReportingInputStream;->notificationThreshold:I

    .line 84
    return-void
.end method
