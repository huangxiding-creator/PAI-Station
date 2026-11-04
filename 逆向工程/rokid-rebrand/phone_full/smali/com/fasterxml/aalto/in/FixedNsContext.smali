.class public final Lcom/fasterxml/aalto/in/FixedNsContext;
.super Ljava/lang/Object;
.source "FixedNsContext.java"

# interfaces
.implements Ljavax/xml/namespace/NamespaceContext;


# static fields
.field public static final EMPTY_CONTEXT:Lcom/fasterxml/aalto/in/FixedNsContext;


# instance fields
.field protected final _declarationData:[Ljava/lang/String;

.field protected final _lastDeclaration:Lcom/fasterxml/aalto/in/NsDeclaration;

.field protected _tmpDecl:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 22
    new-instance v0, Lcom/fasterxml/aalto/in/FixedNsContext;

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/String;

    const/4 v2, 0x0

    invoke-direct {v0, v2, v1}, Lcom/fasterxml/aalto/in/FixedNsContext;-><init>(Lcom/fasterxml/aalto/in/NsDeclaration;[Ljava/lang/String;)V

    sput-object v0, Lcom/fasterxml/aalto/in/FixedNsContext;->EMPTY_CONTEXT:Lcom/fasterxml/aalto/in/FixedNsContext;

    .line 23
    return-void
.end method

.method private constructor <init>(Lcom/fasterxml/aalto/in/NsDeclaration;[Ljava/lang/String;)V
    .locals 1
    .param p1, "lastDecl"    # Lcom/fasterxml/aalto/in/NsDeclaration;
    .param p2, "declData"    # [Ljava/lang/String;

    .line 54
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 51
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_tmpDecl:Ljava/util/ArrayList;

    .line 55
    iput-object p1, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_lastDeclaration:Lcom/fasterxml/aalto/in/NsDeclaration;

    .line 56
    iput-object p2, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_declarationData:[Ljava/lang/String;

    .line 57
    return-void
.end method


# virtual methods
.method public final getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "prefix"    # Ljava/lang/String;

    .line 103
    if-eqz p1, :cond_4

    .line 106
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_1

    .line 107
    const-string/jumbo v0, "xml"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 108
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    return-object v0

    .line 110
    :cond_0
    const-string/jumbo v0, "xmlns"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 111
    const-string v0, "http://www.w3.org/2000/xmlns/"

    return-object v0

    .line 115
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_declarationData:[Ljava/lang/String;

    .line 116
    .local v0, "ns":[Ljava/lang/String;
    const/4 v1, 0x0

    .local v1, "i":I
    array-length v2, v0

    .local v2, "len":I
    :goto_0
    if-ge v1, v2, :cond_3

    .line 117
    aget-object v3, v0, v1

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 118
    add-int/lit8 v3, v1, 0x1

    aget-object v3, v0, v3

    return-object v3

    .line 116
    :cond_2
    add-int/lit8 v1, v1, 0x2

    goto :goto_0

    .line 121
    .end local v1    # "i":I
    .end local v2    # "len":I
    :cond_3
    const/4 v1, 0x0

    return-object v1

    .line 104
    .end local v0    # "ns":[Ljava/lang/String;
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Null prefix not allowed"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p1, "nsURI"    # Ljava/lang/String;

    .line 130
    if-eqz p1, :cond_6

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_6

    .line 133
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 134
    const-string/jumbo v0, "xml"

    return-object v0

    .line 136
    :cond_0
    const-string v0, "http://www.w3.org/2000/xmlns/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 137
    const-string/jumbo v0, "xmlns"

    return-object v0

    .line 139
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_declarationData:[Ljava/lang/String;

    .line 142
    .local v0, "ns":[Ljava/lang/String;
    const/4 v1, 0x1

    .local v1, "i":I
    array-length v2, v0

    .local v2, "len":I
    :goto_0
    if-ge v1, v2, :cond_5

    .line 143
    aget-object v3, v0, v1

    invoke-virtual {p1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    .line 145
    add-int/lit8 v3, v1, -0x1

    aget-object v3, v0, v3

    .line 146
    .local v3, "prefix":Ljava/lang/String;
    add-int/lit8 v4, v1, 0x1

    .local v4, "j":I
    :goto_1
    if-ge v4, v2, :cond_3

    .line 148
    aget-object v5, v0, v4

    if-ne v5, v3, :cond_2

    .line 149
    goto :goto_2

    .line 146
    :cond_2
    add-int/lit8 v4, v4, 0x2

    goto :goto_1

    .line 152
    .end local v4    # "j":I
    :cond_3
    add-int/lit8 v4, v1, -0x1

    aget-object v4, v0, v4

    return-object v4

    .line 142
    .end local v3    # "prefix":Ljava/lang/String;
    :cond_4
    :goto_2
    add-int/lit8 v1, v1, 0x2

    goto :goto_0

    .line 155
    .end local v1    # "i":I
    .end local v2    # "len":I
    :cond_5
    const/4 v1, 0x0

    return-object v1

    .line 131
    .end local v0    # "ns":[Ljava/lang/String;
    :cond_6
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Illegal to pass null/empty prefix as argument."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public final getPrefixes(Ljava/lang/String;)Ljava/util/Iterator;
    .locals 9
    .param p1, "nsURI"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/Iterator<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .line 164
    if-eqz p1, :cond_b

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_b

    .line 167
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 168
    const-string/jumbo v0, "xml"

    invoke-static {v0}, Lorg/codehaus/stax2/ri/SingletonIterator;->create(Ljava/lang/Object;)Lorg/codehaus/stax2/ri/SingletonIterator;

    move-result-object v0

    return-object v0

    .line 170
    :cond_0
    const-string v0, "http://www.w3.org/2000/xmlns/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 171
    const-string/jumbo v0, "xmlns"

    invoke-static {v0}, Lorg/codehaus/stax2/ri/SingletonIterator;->create(Ljava/lang/Object;)Lorg/codehaus/stax2/ri/SingletonIterator;

    move-result-object v0

    return-object v0

    .line 174
    :cond_1
    iget-object v0, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_declarationData:[Ljava/lang/String;

    .line 176
    .local v0, "ns":[Ljava/lang/String;
    const/4 v1, 0x0

    .line 177
    .local v1, "first":Ljava/lang/String;
    const/4 v2, 0x0

    .line 180
    .local v2, "all":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    const/4 v3, 0x1

    .local v3, "i":I
    array-length v4, v0

    .local v4, "len":I
    :goto_0
    if-ge v3, v4, :cond_8

    .line 181
    aget-object v5, v0, v3

    .line 182
    .local v5, "currNS":Ljava/lang/String;
    if-eq v5, p1, :cond_2

    invoke-virtual {v5, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v6

    if-eqz v6, :cond_7

    .line 184
    :cond_2
    add-int/lit8 v6, v3, -0x1

    aget-object v6, v0, v6

    .line 185
    .local v6, "prefix":Ljava/lang/String;
    add-int/lit8 v7, v3, 0x1

    .local v7, "j":I
    :goto_1
    if-ge v7, v4, :cond_4

    .line 187
    aget-object v8, v0, v7

    if-ne v8, v6, :cond_3

    .line 188
    goto :goto_2

    .line 185
    :cond_3
    add-int/lit8 v7, v7, 0x2

    goto :goto_1

    .line 191
    .end local v7    # "j":I
    :cond_4
    if-nez v1, :cond_5

    .line 192
    move-object v1, v6

    goto :goto_2

    .line 194
    :cond_5
    if-nez v2, :cond_6

    .line 195
    new-instance v7, Ljava/util/ArrayList;

    invoke-direct {v7}, Ljava/util/ArrayList;-><init>()V

    move-object v2, v7

    .line 196
    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 198
    :cond_6
    invoke-virtual {v2, v6}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 180
    .end local v5    # "currNS":Ljava/lang/String;
    .end local v6    # "prefix":Ljava/lang/String;
    :cond_7
    :goto_2
    add-int/lit8 v3, v3, 0x2

    goto :goto_0

    .line 202
    .end local v3    # "i":I
    .end local v4    # "len":I
    :cond_8
    if-eqz v2, :cond_9

    .line 203
    invoke-virtual {v2}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v3

    return-object v3

    .line 205
    :cond_9
    if-eqz v1, :cond_a

    .line 206
    invoke-static {v1}, Lorg/codehaus/stax2/ri/SingletonIterator;->create(Ljava/lang/Object;)Lorg/codehaus/stax2/ri/SingletonIterator;

    move-result-object v3

    return-object v3

    .line 208
    :cond_a
    invoke-static {}, Lorg/codehaus/stax2/ri/EmptyIterator;->getInstance()Ljava/util/Iterator;

    move-result-object v3

    return-object v3

    .line 165
    .end local v0    # "ns":[Ljava/lang/String;
    .end local v1    # "first":Ljava/lang/String;
    .end local v2    # "all":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_b
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Illegal to pass null/empty prefix as argument."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public reuseOrCreate(Lcom/fasterxml/aalto/in/NsDeclaration;)Lcom/fasterxml/aalto/in/FixedNsContext;
    .locals 3
    .param p1, "currLastDecl"    # Lcom/fasterxml/aalto/in/NsDeclaration;

    .line 66
    iget-object v0, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_lastDeclaration:Lcom/fasterxml/aalto/in/NsDeclaration;

    if-ne p1, v0, :cond_0

    .line 67
    return-object p0

    .line 70
    :cond_0
    sget-object v0, Lcom/fasterxml/aalto/in/FixedNsContext;->EMPTY_CONTEXT:Lcom/fasterxml/aalto/in/FixedNsContext;

    if-ne p0, v0, :cond_2

    .line 71
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 72
    .local v0, "tmp":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    move-object v1, p1

    .local v1, "curr":Lcom/fasterxml/aalto/in/NsDeclaration;
    :goto_0
    if-eqz v1, :cond_1

    .line 73
    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrefix()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 74
    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/NsDeclaration;->getCurrNsURI()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 72
    invoke-virtual {v1}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrev()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v1

    goto :goto_0

    .line 76
    .end local v1    # "curr":Lcom/fasterxml/aalto/in/NsDeclaration;
    :cond_1
    new-instance v1, Lcom/fasterxml/aalto/in/FixedNsContext;

    invoke-virtual {v0}, Ljava/util/ArrayList;->size()I

    move-result v2

    new-array v2, v2, [Ljava/lang/String;

    invoke-virtual {v0, v2}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v2

    check-cast v2, [Ljava/lang/String;

    invoke-direct {v1, p1, v2}, Lcom/fasterxml/aalto/in/FixedNsContext;-><init>(Lcom/fasterxml/aalto/in/NsDeclaration;[Ljava/lang/String;)V

    return-object v1

    .line 79
    .end local v0    # "tmp":Ljava/util/ArrayList;, "Ljava/util/ArrayList<Ljava/lang/String;>;"
    :cond_2
    iget-object v0, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_tmpDecl:Ljava/util/ArrayList;

    if-nez v0, :cond_3

    .line 80
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_tmpDecl:Ljava/util/ArrayList;

    goto :goto_1

    .line 82
    :cond_3
    iget-object v0, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_tmpDecl:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    .line 84
    :goto_1
    move-object v0, p1

    .local v0, "curr":Lcom/fasterxml/aalto/in/NsDeclaration;
    :goto_2
    if-eqz v0, :cond_4

    .line 85
    iget-object v1, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_tmpDecl:Ljava/util/ArrayList;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrefix()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 86
    iget-object v1, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_tmpDecl:Ljava/util/ArrayList;

    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getCurrNsURI()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 84
    invoke-virtual {v0}, Lcom/fasterxml/aalto/in/NsDeclaration;->getPrev()Lcom/fasterxml/aalto/in/NsDeclaration;

    move-result-object v0

    goto :goto_2

    .line 88
    .end local v0    # "curr":Lcom/fasterxml/aalto/in/NsDeclaration;
    :cond_4
    new-instance v0, Lcom/fasterxml/aalto/in/FixedNsContext;

    iget-object v1, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_tmpDecl:Ljava/util/ArrayList;

    iget-object v2, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_tmpDecl:Ljava/util/ArrayList;

    invoke-virtual {v2}, Ljava/util/ArrayList;->size()I

    move-result v2

    new-array v2, v2, [Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object v1

    check-cast v1, [Ljava/lang/String;

    invoke-direct {v0, p1, v1}, Lcom/fasterxml/aalto/in/FixedNsContext;-><init>(Lcom/fasterxml/aalto/in/NsDeclaration;[Ljava/lang/String;)V

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 6

    .line 220
    sget-object v0, Lcom/fasterxml/aalto/in/FixedNsContext;->EMPTY_CONTEXT:Lcom/fasterxml/aalto/in/FixedNsContext;

    if-ne p0, v0, :cond_0

    .line 221
    const-string v0, "[EMPTY non-transient NsContext]"

    return-object v0

    .line 223
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 224
    .local v0, "sb":Ljava/lang/StringBuilder;
    const/16 v1, 0x5b

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 225
    const/4 v1, 0x0

    .local v1, "i":I
    iget-object v2, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_declarationData:[Ljava/lang/String;

    array-length v2, v2

    .local v2, "len":I
    :goto_0
    if-ge v1, v2, :cond_2

    .line 226
    if-lez v1, :cond_1

    .line 227
    const-string v3, ", "

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 229
    :cond_1
    const/16 v3, 0x22

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_declarationData:[Ljava/lang/String;

    aget-object v5, v5, v1

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\"->\""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 230
    iget-object v4, p0, Lcom/fasterxml/aalto/in/FixedNsContext;->_declarationData:[Ljava/lang/String;

    add-int/lit8 v5, v1, 0x1

    aget-object v4, v4, v5

    invoke-virtual {v0, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 225
    add-int/lit8 v1, v1, 0x2

    goto :goto_0

    .line 232
    .end local v1    # "i":I
    .end local v2    # "len":I
    :cond_2
    const/16 v1, 0x5d

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 233
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    return-object v1
.end method
