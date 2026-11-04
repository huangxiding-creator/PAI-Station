.class Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;
.super Ljava/lang/Object;
.source "FastDoubleMath.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = "UInt128"
.end annotation


# instance fields
.field final high:J

.field final low:J


# direct methods
.method private constructor <init>(JJ)V
    .locals 0
    .param p1, "high"    # J
    .param p3, "low"    # J

    .line 1109
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 1110
    iput-wide p1, p0, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;->high:J

    .line 1111
    iput-wide p3, p0, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;->low:J

    .line 1112
    return-void
.end method

.method synthetic constructor <init>(JJLcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$1;)V
    .locals 0
    .param p1, "x0"    # J
    .param p3, "x1"    # J
    .param p5, "x2"    # Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$1;

    .line 1106
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/fasterxml/jackson/core/io/doubleparser/FastDoubleMath$UInt128;-><init>(JJ)V

    return-void
.end method
