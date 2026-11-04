.class public abstract Lorg/codehaus/stax2/ri/typed/AsciiValueEncoder;
.super Ljava/lang/Object;
.source "AsciiValueEncoder.java"


# static fields
.field protected static final MIN_CHARS_WITHOUT_FLUSH:I = 0x40


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 72
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final bufferNeedsFlush(I)Z
    .locals 1
    .param p1, "freeChars"    # I

    .line 99
    const/16 v0, 0x40

    if-ge p1, v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method public abstract encodeMore([BII)I
.end method

.method public abstract encodeMore([CII)I
.end method

.method public abstract isCompleted()Z
.end method
