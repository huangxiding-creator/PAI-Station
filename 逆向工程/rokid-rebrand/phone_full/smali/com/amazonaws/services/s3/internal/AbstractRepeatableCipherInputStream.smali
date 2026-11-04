.class public abstract Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;
.super Lcom/amazonaws/internal/SdkFilterInputStream;
.source "AbstractRepeatableCipherInputStream.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Lcom/amazonaws/internal/SdkFilterInputStream;"
    }
.end annotation


# instance fields
.field private final cipherFactory:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field

.field private hasBeenAccessed:Z

.field private final unencryptedDataStream:Ljava/io/InputStream;


# direct methods
.method protected constructor <init>(Ljava/io/InputStream;Ljava/io/FilterInputStream;Ljava/lang/Object;)V
    .locals 0
    .param p1, "input"    # Ljava/io/InputStream;
    .param p2, "cipherInputStream"    # Ljava/io/FilterInputStream;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/InputStream;",
            "Ljava/io/FilterInputStream;",
            "TT;)V"
        }
    .end annotation

    .line 69
    .local p0, "this":Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;, "Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream<TT;>;"
    .local p3, "cipherFactory":Ljava/lang/Object;, "TT;"
    invoke-direct {p0, p2}, Lcom/amazonaws/internal/SdkFilterInputStream;-><init>(Ljava/io/InputStream;)V

    .line 70
    iput-object p1, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->unencryptedDataStream:Ljava/io/InputStream;

    .line 71
    iput-object p3, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->cipherFactory:Ljava/lang/Object;

    .line 72
    return-void
.end method


# virtual methods
.method protected abstract createCipherInputStream(Ljava/io/InputStream;Ljava/lang/Object;)Ljava/io/FilterInputStream;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/InputStream;",
            "TT;)",
            "Ljava/io/FilterInputStream;"
        }
    .end annotation
.end method

.method public mark(I)V
    .locals 2
    .param p1, "readlimit"    # I

    .line 82
    .local p0, "this":Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;, "Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream<TT;>;"
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->abortIfNeeded()V

    .line 83
    iget-boolean v0, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->hasBeenAccessed:Z

    if-nez v0, :cond_0

    .line 89
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->unencryptedDataStream:Ljava/io/InputStream;

    invoke-virtual {v0, p1}, Ljava/io/InputStream;->mark(I)V

    .line 90
    return-void

    .line 84
    :cond_0
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "Marking is only supported before your first call to read or skip."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public markSupported()Z
    .locals 1

    .line 76
    .local p0, "this":Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;, "Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream<TT;>;"
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->abortIfNeeded()V

    .line 77
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->unencryptedDataStream:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->markSupported()Z

    move-result v0

    return v0
.end method

.method public read()I
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 102
    .local p0, "this":Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;, "Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream<TT;>;"
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->hasBeenAccessed:Z

    .line 103
    invoke-super {p0}, Lcom/amazonaws/internal/SdkFilterInputStream;->read()I

    move-result v0

    return v0
.end method

.method public read([B)I
    .locals 1
    .param p1, "b"    # [B
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 108
    .local p0, "this":Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;, "Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream<TT;>;"
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->hasBeenAccessed:Z

    .line 109
    invoke-super {p0, p1}, Lcom/amazonaws/internal/SdkFilterInputStream;->read([B)I

    move-result v0

    return v0
.end method

.method public read([BII)I
    .locals 1
    .param p1, "b"    # [B
    .param p2, "off"    # I
    .param p3, "len"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 116
    .local p0, "this":Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;, "Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream<TT;>;"
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->hasBeenAccessed:Z

    .line 117
    invoke-super {p0, p1, p2, p3}, Lcom/amazonaws/internal/SdkFilterInputStream;->read([BII)I

    move-result v0

    return v0
.end method

.method public reset()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 94
    .local p0, "this":Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;, "Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream<TT;>;"
    invoke-virtual {p0}, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->abortIfNeeded()V

    .line 95
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->unencryptedDataStream:Ljava/io/InputStream;

    invoke-virtual {v0}, Ljava/io/InputStream;->reset()V

    .line 96
    iget-object v0, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->unencryptedDataStream:Ljava/io/InputStream;

    iget-object v1, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->cipherFactory:Ljava/lang/Object;

    invoke-virtual {p0, v0, v1}, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->createCipherInputStream(Ljava/io/InputStream;Ljava/lang/Object;)Ljava/io/FilterInputStream;

    move-result-object v0

    iput-object v0, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->in:Ljava/io/InputStream;

    .line 97
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->hasBeenAccessed:Z

    .line 98
    return-void
.end method

.method public skip(J)J
    .locals 2
    .param p1, "n"    # J
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 122
    .local p0, "this":Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;, "Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream<TT;>;"
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/amazonaws/services/s3/internal/AbstractRepeatableCipherInputStream;->hasBeenAccessed:Z

    .line 123
    invoke-super {p0, p1, p2}, Lcom/amazonaws/internal/SdkFilterInputStream;->skip(J)J

    move-result-wide v0

    return-wide v0
.end method
