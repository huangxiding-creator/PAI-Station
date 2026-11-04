.class public abstract Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;
.super Lorg/codehaus/stax2/typed/TypedArrayDecoder;
.source "ValueDecoderFactory.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "BaseArrayDecoder"
.end annotation


# static fields
.field protected static final INITIAL_RESULT_BUFFER_SIZE:I = 0x28

.field protected static final SMALL_RESULT_BUFFER_SIZE:I = 0xfa0


# instance fields
.field protected mCount:I

.field protected mEnd:I

.field protected mStart:I


# direct methods
.method protected constructor <init>(II)V
    .locals 2
    .param p1, "start"    # I
    .param p2, "maxCount"    # I

    .line 1195
    invoke-direct {p0}, Lorg/codehaus/stax2/typed/TypedArrayDecoder;-><init>()V

    .line 1192
    const/4 v0, 0x0

    iput v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;->mCount:I

    .line 1196
    iput p1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;->mStart:I

    .line 1198
    const/4 v0, 0x1

    if-lt p2, v0, :cond_0

    .line 1201
    iput p2, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;->mEnd:I

    .line 1202
    return-void

    .line 1199
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Number of elements to read can not be less than 1"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method protected calcNewSize(I)I
    .locals 1
    .param p1, "currSize"    # I

    .line 1219
    const/16 v0, 0xfa0

    if-ge p1, v0, :cond_0

    .line 1220
    shl-int/lit8 v0, p1, 0x2

    return v0

    .line 1222
    :cond_0
    add-int v0, p1, p1

    return v0
.end method

.method public abstract expand()V
.end method

.method public final getCount()I
    .locals 1

    .line 1205
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;->mCount:I

    return v0
.end method

.method public final hasRoom()Z
    .locals 2

    .line 1208
    iget v0, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;->mCount:I

    iget v1, p0, Lorg/codehaus/stax2/ri/typed/ValueDecoderFactory$BaseArrayDecoder;->mEnd:I

    if-ge v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method
