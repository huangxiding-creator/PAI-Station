.class public Lorg/codehaus/stax2/typed/TypedXMLStreamException;
.super Ljavax/xml/stream/XMLStreamException;
.source "TypedXMLStreamException.java"


# static fields
.field private static final serialVersionUID:J = 0x1L


# instance fields
.field protected mLexical:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/IllegalArgumentException;)V
    .locals 0
    .param p1, "lexical"    # Ljava/lang/String;
    .param p2, "rootCause"    # Ljava/lang/IllegalArgumentException;

    .line 62
    invoke-direct {p0, p2}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/Throwable;)V

    .line 63
    iput-object p1, p0, Lorg/codehaus/stax2/typed/TypedXMLStreamException;->mLexical:Ljava/lang/String;

    .line 64
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "lexical"    # Ljava/lang/String;
    .param p2, "msg"    # Ljava/lang/String;

    .line 50
    invoke-direct {p0, p2}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    .line 51
    iput-object p1, p0, Lorg/codehaus/stax2/typed/TypedXMLStreamException;->mLexical:Ljava/lang/String;

    .line 52
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/IllegalArgumentException;)V
    .locals 0
    .param p1, "lexical"    # Ljava/lang/String;
    .param p2, "msg"    # Ljava/lang/String;
    .param p3, "rootCause"    # Ljava/lang/IllegalArgumentException;

    .line 74
    invoke-direct {p0, p2, p3}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 75
    iput-object p1, p0, Lorg/codehaus/stax2/typed/TypedXMLStreamException;->mLexical:Ljava/lang/String;

    .line 76
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;)V
    .locals 0
    .param p1, "lexical"    # Ljava/lang/String;
    .param p2, "msg"    # Ljava/lang/String;
    .param p3, "location"    # Ljavax/xml/stream/Location;

    .line 104
    invoke-direct {p0, p2, p3}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;Ljavax/xml/stream/Location;)V

    .line 105
    iput-object p1, p0, Lorg/codehaus/stax2/typed/TypedXMLStreamException;->mLexical:Ljava/lang/String;

    .line 106
    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/IllegalArgumentException;)V
    .locals 0
    .param p1, "lexical"    # Ljava/lang/String;
    .param p2, "msg"    # Ljava/lang/String;
    .param p3, "location"    # Ljavax/xml/stream/Location;
    .param p4, "rootCause"    # Ljava/lang/IllegalArgumentException;

    .line 90
    invoke-direct {p0, p2, p3, p4}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;Ljavax/xml/stream/Location;Ljava/lang/Throwable;)V

    .line 91
    iput-object p1, p0, Lorg/codehaus/stax2/typed/TypedXMLStreamException;->mLexical:Ljava/lang/String;

    .line 92
    return-void
.end method


# virtual methods
.method public getLexical()Ljava/lang/String;
    .locals 1

    .line 116
    iget-object v0, p0, Lorg/codehaus/stax2/typed/TypedXMLStreamException;->mLexical:Ljava/lang/String;

    return-object v0
.end method
