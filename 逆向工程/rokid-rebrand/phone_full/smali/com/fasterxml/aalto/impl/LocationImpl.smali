.class public Lcom/fasterxml/aalto/impl/LocationImpl;
.super Ljava/lang/Object;
.source "LocationImpl.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamLocation2;


# static fields
.field private static final EMPTY:Lcom/fasterxml/aalto/impl/LocationImpl;


# instance fields
.field protected final _charOffset:I

.field protected final _col:I

.field protected transient _desc:Ljava/lang/String;

.field protected final _publicId:Ljava/lang/String;

.field protected final _row:I

.field protected final _systemId:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 7

    .line 12
    new-instance v6, Lcom/fasterxml/aalto/impl/LocationImpl;

    const/4 v4, -0x1

    const/4 v5, -0x1

    const-string v1, ""

    const-string v2, ""

    const/4 v3, -0x1

    move-object v0, v6

    invoke-direct/range {v0 .. v5}, Lcom/fasterxml/aalto/impl/LocationImpl;-><init>(Ljava/lang/String;Ljava/lang/String;III)V

    sput-object v6, Lcom/fasterxml/aalto/impl/LocationImpl;->EMPTY:Lcom/fasterxml/aalto/impl/LocationImpl;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;III)V
    .locals 1
    .param p1, "pubId"    # Ljava/lang/String;
    .param p2, "sysId"    # Ljava/lang/String;
    .param p3, "charOffset"    # I
    .param p4, "row"    # I
    .param p5, "col"    # I

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 19
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_desc:Ljava/lang/String;

    .line 24
    iput-object p1, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_publicId:Ljava/lang/String;

    .line 25
    iput-object p2, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_systemId:Ljava/lang/String;

    .line 29
    if-gez p3, :cond_0

    const v0, 0x7fffffff

    goto :goto_0

    :cond_0
    move v0, p3

    :goto_0
    iput v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_charOffset:I

    .line 30
    iput p5, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_col:I

    .line 31
    iput p4, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_row:I

    .line 32
    return-void
.end method

.method private appendDesc(Ljava/lang/StringBuffer;)V
    .locals 3
    .param p1, "sb"    # Ljava/lang/StringBuffer;

    .line 105
    iget-object v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_systemId:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 106
    const-string v0, "[row,col,system-id]: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 107
    iget-object v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_systemId:Ljava/lang/String;

    .local v0, "srcId":Ljava/lang/String;
    goto :goto_0

    .line 108
    .end local v0    # "srcId":Ljava/lang/String;
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_publicId:Ljava/lang/String;

    if-eqz v0, :cond_1

    .line 109
    const-string v0, "[row,col,public-id]: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 110
    iget-object v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_publicId:Ljava/lang/String;

    .restart local v0    # "srcId":Ljava/lang/String;
    goto :goto_0

    .line 112
    .end local v0    # "srcId":Ljava/lang/String;
    :cond_1
    const-string v0, "[row,col {unknown-source}]: "

    invoke-virtual {p1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 113
    const/4 v0, 0x0

    .line 115
    .restart local v0    # "srcId":Ljava/lang/String;
    :goto_0
    const/16 v1, 0x5b

    invoke-virtual {p1, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 116
    iget v1, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_row:I

    invoke-virtual {p1, v1}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 117
    const/16 v1, 0x2c

    invoke-virtual {p1, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 118
    iget v2, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_col:I

    invoke-virtual {p1, v2}, Ljava/lang/StringBuffer;->append(I)Ljava/lang/StringBuffer;

    .line 120
    if-eqz v0, :cond_2

    .line 121
    invoke-virtual {p1, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 122
    const/16 v1, 0x22

    invoke-virtual {p1, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 123
    invoke-virtual {p1, v0}, Ljava/lang/StringBuffer;->append(Ljava/lang/String;)Ljava/lang/StringBuffer;

    .line 124
    invoke-virtual {p1, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 126
    :cond_2
    const/16 v1, 0x5d

    invoke-virtual {p1, v1}, Ljava/lang/StringBuffer;->append(C)Ljava/lang/StringBuffer;

    .line 127
    return-void
.end method

.method public static fromZeroBased(Ljava/lang/String;Ljava/lang/String;JII)Lcom/fasterxml/aalto/impl/LocationImpl;
    .locals 8
    .param p0, "pubId"    # Ljava/lang/String;
    .param p1, "sysId"    # Ljava/lang/String;
    .param p2, "rawOffset"    # J
    .param p4, "rawRow"    # I
    .param p5, "rawCol"    # I

    .line 43
    long-to-int v6, p2

    .line 44
    .local v6, "offset":I
    new-instance v7, Lcom/fasterxml/aalto/impl/LocationImpl;

    add-int/lit8 v4, p4, 0x1

    add-int/lit8 v5, p5, 0x1

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move v3, v6

    invoke-direct/range {v0 .. v5}, Lcom/fasterxml/aalto/impl/LocationImpl;-><init>(Ljava/lang/String;Ljava/lang/String;III)V

    return-object v7
.end method

.method public static getEmptyLocation()Lcom/fasterxml/aalto/impl/LocationImpl;
    .locals 1

    .line 48
    sget-object v0, Lcom/fasterxml/aalto/impl/LocationImpl;->EMPTY:Lcom/fasterxml/aalto/impl/LocationImpl;

    return-object v0
.end method


# virtual methods
.method public getCharacterOffset()I
    .locals 1

    .line 52
    iget v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_charOffset:I

    return v0
.end method

.method public getColumnNumber()I
    .locals 1

    .line 55
    iget v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_col:I

    return v0
.end method

.method public getContext()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1

    .line 75
    const/4 v0, 0x0

    return-object v0
.end method

.method public getLineNumber()I
    .locals 1

    .line 58
    iget v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_row:I

    return v0
.end method

.method public getPublicId()Ljava/lang/String;
    .locals 1

    .line 61
    iget-object v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_publicId:Ljava/lang/String;

    return-object v0
.end method

.method public getSystemId()Ljava/lang/String;
    .locals 1

    .line 64
    iget-object v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_systemId:Ljava/lang/String;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 87
    iget-object v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_desc:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 88
    new-instance v0, Ljava/lang/StringBuffer;

    const/16 v1, 0x64

    invoke-direct {v0, v1}, Ljava/lang/StringBuffer;-><init>(I)V

    .line 89
    .local v0, "sb":Ljava/lang/StringBuffer;
    invoke-direct {p0, v0}, Lcom/fasterxml/aalto/impl/LocationImpl;->appendDesc(Ljava/lang/StringBuffer;)V

    .line 90
    invoke-virtual {v0}, Ljava/lang/StringBuffer;->toString()Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_desc:Ljava/lang/String;

    .line 92
    .end local v0    # "sb":Ljava/lang/StringBuffer;
    :cond_0
    iget-object v0, p0, Lcom/fasterxml/aalto/impl/LocationImpl;->_desc:Ljava/lang/String;

    return-object v0
.end method
