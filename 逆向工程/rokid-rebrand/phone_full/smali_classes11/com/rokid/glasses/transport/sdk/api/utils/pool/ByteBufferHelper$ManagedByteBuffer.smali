.class public final Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
.super Ljava/lang/Object;
.source "ByteBufferHelper.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "ManagedByteBuffer"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000&\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\t\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0010\u000e\n\u0000\u0008\u0086\u0008\u0018\u00002\u00020\u0001B\u0015\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0002\u0010\u0006J\t\u0010\u000b\u001a\u00020\u0003H\u00c6\u0003J\t\u0010\u000c\u001a\u00020\u0005H\u00c6\u0003J\u001d\u0010\r\u001a\u00020\u00002\u0008\u0008\u0002\u0010\u0002\u001a\u00020\u00032\u0008\u0008\u0002\u0010\u0004\u001a\u00020\u0005H\u00c6\u0001J\u0013\u0010\u000e\u001a\u00020\u000f2\u0008\u0010\u0010\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010\u0011\u001a\u00020\u0005H\u00d6\u0001J\t\u0010\u0012\u001a\u00020\u0013H\u00d6\u0001R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0007\u0010\u0008R\u0011\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\t\u0010\n\u00a8\u0006\u0014"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;",
        "",
        "buffer",
        "Ljava/nio/ByteBuffer;",
        "originSize",
        "",
        "(Ljava/nio/ByteBuffer;I)V",
        "getBuffer",
        "()Ljava/nio/ByteBuffer;",
        "getOriginSize",
        "()I",
        "component1",
        "component2",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "toString",
        "",
        "sdk-api_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private final buffer:Ljava/nio/ByteBuffer;

.field private final originSize:I


# direct methods
.method public constructor <init>(Ljava/nio/ByteBuffer;I)V
    .locals 1
    .param p1, "buffer"    # Ljava/nio/ByteBuffer;
    .param p2, "originSize"    # I

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->buffer:Ljava/nio/ByteBuffer;

    iput p2, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->originSize:I

    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;Ljava/nio/ByteBuffer;IILjava/lang/Object;)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    .locals 0

    and-int/lit8 p4, p3, 0x1

    if-eqz p4, :cond_0

    iget-object p1, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->buffer:Ljava/nio/ByteBuffer;

    :cond_0
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_1

    iget p2, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->originSize:I

    :cond_1
    invoke-virtual {p0, p1, p2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->copy(Ljava/nio/ByteBuffer;I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()Ljava/nio/ByteBuffer;
    .locals 1

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->buffer:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public final component2()I
    .locals 1

    iget v0, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->originSize:I

    return v0
.end method

.method public final copy(Ljava/nio/ByteBuffer;I)Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;
    .locals 1

    const-string v0, "buffer"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    invoke-direct {v0, p1, p2}, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;-><init>(Ljava/nio/ByteBuffer;I)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;

    iget-object v3, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->buffer:Ljava/nio/ByteBuffer;

    iget-object v4, v1, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->buffer:Ljava/nio/ByteBuffer;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    return v2

    :cond_2
    iget v3, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->originSize:I

    iget v1, v1, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->originSize:I

    if-eq v3, v1, :cond_3

    return v2

    :cond_3
    return v0
.end method

.method public final getBuffer()Ljava/nio/ByteBuffer;
    .locals 1

    .line 50
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->buffer:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public final getOriginSize()I
    .locals 1

    .line 50
    iget v0, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->originSize:I

    return v0
.end method

.method public hashCode()I
    .locals 3

    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->hashCode()I

    move-result v0

    mul-int/lit8 v1, v0, 0x1f

    iget v2, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->originSize:I

    invoke-static {v2}, Ljava/lang/Integer;->hashCode(I)I

    move-result v2

    add-int/2addr v1, v2

    return v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "ManagedByteBuffer(buffer="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->buffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", originSize="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/glasses/transport/sdk/api/utils/pool/ByteBufferHelper$ManagedByteBuffer;->originSize:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
