.class public Lorg/codehaus/stax2/ri/EmptyNamespaceContext;
.super Ljava/lang/Object;
.source "EmptyNamespaceContext.java"

# interfaces
.implements Ljavax/xml/namespace/NamespaceContext;


# static fields
.field static final sInstance:Lorg/codehaus/stax2/ri/EmptyNamespaceContext;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 16
    new-instance v0, Lorg/codehaus/stax2/ri/EmptyNamespaceContext;

    invoke-direct {v0}, Lorg/codehaus/stax2/ri/EmptyNamespaceContext;-><init>()V

    sput-object v0, Lorg/codehaus/stax2/ri/EmptyNamespaceContext;->sInstance:Lorg/codehaus/stax2/ri/EmptyNamespaceContext;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getInstance()Lorg/codehaus/stax2/ri/EmptyNamespaceContext;
    .locals 1

    .line 20
    sget-object v0, Lorg/codehaus/stax2/ri/EmptyNamespaceContext;->sInstance:Lorg/codehaus/stax2/ri/EmptyNamespaceContext;

    return-object v0
.end method


# virtual methods
.method public final getNamespaceURI(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "prefix"    # Ljava/lang/String;

    .line 34
    if-eqz p1, :cond_2

    .line 37
    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-lez v0, :cond_1

    .line 38
    const-string v0, "xml"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 39
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    return-object v0

    .line 41
    :cond_0
    const-string v0, "xmlns"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 42
    const-string v0, "http://www.w3.org/2000/xmlns/"

    return-object v0

    .line 45
    :cond_1
    const/4 v0, 0x0

    return-object v0

    .line 35
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Illegal to pass null/empty prefix as argument."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getPrefix(Ljava/lang/String;)Ljava/lang/String;
    .locals 2
    .param p1, "nsURI"    # Ljava/lang/String;

    .line 54
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_2

    .line 57
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 58
    const-string v0, "xml"

    return-object v0

    .line 60
    :cond_0
    const-string v0, "http://www.w3.org/2000/xmlns/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 61
    const-string v0, "xmlns"

    return-object v0

    .line 63
    :cond_1
    const/4 v0, 0x0

    return-object v0

    .line 55
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Illegal to pass null/empty URI as argument."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public getPrefixes(Ljava/lang/String;)Ljava/util/Iterator;
    .locals 2
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

    .line 72
    if-eqz p1, :cond_2

    invoke-virtual {p1}, Ljava/lang/String;->length()I

    move-result v0

    if-eqz v0, :cond_2

    .line 75
    const-string v0, "http://www.w3.org/XML/1998/namespace"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 76
    const-string v0, "xml"

    invoke-static {v0}, Lorg/codehaus/stax2/ri/SingletonIterator;->create(Ljava/lang/Object;)Lorg/codehaus/stax2/ri/SingletonIterator;

    move-result-object v0

    return-object v0

    .line 78
    :cond_0
    const-string v0, "http://www.w3.org/2000/xmlns/"

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 79
    const-string v0, "xmlns"

    invoke-static {v0}, Lorg/codehaus/stax2/ri/SingletonIterator;->create(Ljava/lang/Object;)Lorg/codehaus/stax2/ri/SingletonIterator;

    move-result-object v0

    return-object v0

    .line 81
    :cond_1
    invoke-static {}, Lorg/codehaus/stax2/ri/EmptyIterator;->getInstance()Ljava/util/Iterator;

    move-result-object v0

    return-object v0

    .line 73
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Illegal to pass null/empty prefix as argument."

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
