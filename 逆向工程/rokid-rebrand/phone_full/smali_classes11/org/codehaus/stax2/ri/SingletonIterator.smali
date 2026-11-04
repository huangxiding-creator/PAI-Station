.class public Lorg/codehaus/stax2/ri/SingletonIterator;
.super Ljava/lang/Object;
.source "SingletonIterator.java"

# interfaces
.implements Ljava/util/Iterator;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Ljava/lang/Object;",
        "Ljava/util/Iterator<",
        "TT;>;"
    }
.end annotation


# instance fields
.field private _done:Z

.field private final _value:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/Object;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    .line 16
    .local p0, "this":Lorg/codehaus/stax2/ri/SingletonIterator;, "Lorg/codehaus/stax2/ri/SingletonIterator<TT;>;"
    .local p1, "value":Ljava/lang/Object;, "TT;"
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 13
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/SingletonIterator;->_done:Z

    .line 17
    iput-object p1, p0, Lorg/codehaus/stax2/ri/SingletonIterator;->_value:Ljava/lang/Object;

    .line 18
    return-void
.end method

.method public static create(Ljava/lang/Object;)Lorg/codehaus/stax2/ri/SingletonIterator;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(TT;)",
            "Lorg/codehaus/stax2/ri/SingletonIterator<",
            "TT;>;"
        }
    .end annotation

    .line 21
    .local p0, "value":Ljava/lang/Object;, "TT;"
    new-instance v0, Lorg/codehaus/stax2/ri/SingletonIterator;

    invoke-direct {v0, p0}, Lorg/codehaus/stax2/ri/SingletonIterator;-><init>(Ljava/lang/Object;)V

    return-object v0
.end method


# virtual methods
.method public hasNext()Z
    .locals 1

    .line 26
    .local p0, "this":Lorg/codehaus/stax2/ri/SingletonIterator;, "Lorg/codehaus/stax2/ri/SingletonIterator<TT;>;"
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/SingletonIterator;->_done:Z

    xor-int/lit8 v0, v0, 0x1

    return v0
.end method

.method public next()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    .line 31
    .local p0, "this":Lorg/codehaus/stax2/ri/SingletonIterator;, "Lorg/codehaus/stax2/ri/SingletonIterator<TT;>;"
    iget-boolean v0, p0, Lorg/codehaus/stax2/ri/SingletonIterator;->_done:Z

    if-nez v0, :cond_0

    .line 34
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/codehaus/stax2/ri/SingletonIterator;->_done:Z

    .line 35
    iget-object v0, p0, Lorg/codehaus/stax2/ri/SingletonIterator;->_value:Ljava/lang/Object;

    return-object v0

    .line 32
    :cond_0
    new-instance v0, Ljava/util/NoSuchElementException;

    invoke-direct {v0}, Ljava/util/NoSuchElementException;-><init>()V

    throw v0
.end method

.method public remove()V
    .locals 2

    .line 41
    .local p0, "this":Lorg/codehaus/stax2/ri/SingletonIterator;, "Lorg/codehaus/stax2/ri/SingletonIterator<TT;>;"
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "Can not remove item from SingletonIterator."

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
