.class public Lorg/xerial/snappy/BitShuffleNative;
.super Ljava/lang/Object;
.source "BitShuffleNative.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public native shuffle(Ljava/lang/Object;IIILjava/lang/Object;I)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method public native shuffleDirectBuffer(Ljava/nio/ByteBuffer;IIILjava/nio/ByteBuffer;I)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method public native unshuffle(Ljava/lang/Object;IIILjava/lang/Object;I)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method

.method public native unshuffleDirectBuffer(Ljava/nio/ByteBuffer;IIILjava/nio/ByteBuffer;I)I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method
