.class Lorg/apache/log4j/spi/NullWriter;
.super Ljava/io/Writer;
.source "NullWriter.java"


# direct methods
.method constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/io/Writer;-><init>()V

    return-void
.end method


# virtual methods
.method public close()V
    .locals 0

    .line 30
    return-void
.end method

.method public flush()V
    .locals 0

    .line 34
    return-void
.end method

.method public write([CII)V
    .locals 0
    .param p1, "cbuf"    # [C
    .param p2, "off"    # I
    .param p3, "len"    # I

    .line 38
    return-void
.end method
